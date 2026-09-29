module fifo_dut(fifo_if.DUT FIFOif);
    localparam max_fifo_addr = $clog2(FIFOif.FIFO_DEPTH);
    reg [FIFOif.FIFO_WIDTH-1:0] mem [FIFOif.FIFO_DEPTH-1:0];
    reg [max_fifo_addr-1:0]wr_ptr, rd_ptr;
    reg [max_fifo_addr:0]count;

    always @(posedge FIFOif.clk or negedge FIFOif.rst_n) begin
        if(!FIFOif.rst_n) begin
            wr_ptr <= 0;
        end
        else if(FIFOif.wr_en && count < FIFOif.FIFO_DEPTH) begin
            mem[wr_ptr] <= FIFOif.data_in;
            wr_ptr <= wr_ptr + 1;
        end
    end
    
    always @(posedge FIFOif.clk or negedge FIFOif.rst_n) begin
        if(!FIFOif.rst_n) begin
            rd_ptr <= 0;
        end
        else if(FIFOif.rd_en && count != 0) begin
            FIFOif.data_out <= mem[rd_ptr];
            rd_ptr <= rd_ptr + 1;
        end
    end

    always @(posedge FIFOif.clk or negedge FIFOif.rst_n) begin
        if(!FIFOif.rst_n) begin
            count <= 0;
        end
        else begin
            if ( (({FIFOif.wr_en, FIFOif.rd_en}==2'b10) && !FIFOif.full) || (({FIFOif.wr_en, FIFOif.rd_en}==2'b11) && FIFOif.empty)  ) 
                count <= count + 1;
            else if( (({FIFOif.wr_en, FIFOif.rd_en}==2'b01) && !FIFOif.empty) || (({FIFOif.wr_en, FIFOif.rd_en}==2'b11) && FIFOif.full)  ) begin
                count <= count - 1;
            end
        end
    end

    assign FIFOif.full = (count == FIFOif.FIFO_DEPTH)? 1:0;
    assign FIFOif.empty = (count == 0)? 1:0;
    assign FIFOif.underflow = (FIFOif.empty && FIFOif.rd_en)? 1:0;
    assign FIFOif.overflow = (FIFOif.full && FIFOif.wr_en)? 1:0;
    assign FIFOif.almostempty = (count == 1)? 1:0;
    assign FIFOif.wr_ack = ((count != FIFOif.FIFO_DEPTH) && FIFOif.wr_en)? 1:0;
    assign FIFOif.almostfull = (count == FIFOif.FIFO_DEPTH - 1)? 1:0;

endmodule

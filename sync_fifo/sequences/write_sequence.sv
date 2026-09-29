class write_sequence extends uvm_sequence #(fifo_transaction);
    `uvm_object_utils(write_sequence)
    int unsigned num_item = 8;

    function new(string name = "write_sequence");
        super.new(name);
    endfunction: new

    virtual task body();
        fifo_transaction trans;
        `uvm_info("body",$sformatf("ENTERED...."),UVM_LOW)
        trans = fifo_transaction :: type_id :: create ("trans");
        repeat (num_item) begin
            start_item(trans);
            if(trans.randomize() with {wr_en == 1'b1; rd_en == 1'b0;} ) begin
                `uvm_info("body",$sformatf("Transaction randomize is: \n %s", trans.sprint()),UVM_LOW)
            end else begin
                `uvm_fatal("body",$sformatf("Randomize failed !!!!"))
            end
            finish_item(trans);
        end
        `uvm_info("body",$sformatf("EXITING...."),UVM_LOW)
    endtask: body
endclass: write_sequence

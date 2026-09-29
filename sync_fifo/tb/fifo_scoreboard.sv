class fifo_scoreboard extends uvm_scoreboard;
      
    `uvm_component_utils(fifo_scoreboard)
    uvm_analysis_imp#(fifo_transaction, fifo_scoreboard) scb_import;
    fifo_transaction exp_queue[$:7];
    fifo_transaction act_queue[$:7];
    int cnt = 0;
  

    function new(string name = "fifo_scoreboard", uvm_component parent);
        super.new(name,parent);
        scb_import = new("scb_import",this);
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction: build_phase

    virtual function void write(fifo_transaction trans);
        int cnt_pre;
        if(!trans.rst_n)begin
            cnt = 0;
            exp_queue.delete();
            act_queue.delete();
            return;
        end
        
        cnt_pre = cnt;

        if(cnt == 8 && trans.full)begin
            `uvm_info(get_type_name(),$sformatf("The FIFO is FULL"), UVM_LOW)
            `uvm_info(get_type_name(),$sformatf("Element of FIFO = %0d",cnt), UVM_LOW)
        end else if((cnt == 8) !== (trans.full)) begin
            `uvm_error(get_type_name(),$sformatf("[FAILD] The FIFO isn't FULL !!!!!!!!!"))
        end

        if(cnt == 0 && trans.empty)begin
            `uvm_info(get_type_name(),$sformatf("The FIFO is EMPTY"), UVM_LOW)
            `uvm_info(get_type_name(),$sformatf("Element of FIFO = %0d",cnt), UVM_LOW)
        end else if((cnt == 0) !== (trans.empty)) begin
            `uvm_error(get_type_name(),$sformatf("[FAILD] The FIFO isn't EMPTY !!!!!!!!!"))
        end

        if(cnt == 7 && trans.almostfull)begin
            `uvm_info(get_type_name(),$sformatf("The FIFO is ALMOSTFULL"), UVM_LOW)
            `uvm_info(get_type_name(),$sformatf("Element of FIFO = %0d",cnt), UVM_LOW)
        end else if((cnt == 7) !== (trans.almostfull)) begin
            `uvm_error(get_type_name(),$sformatf("[FAILD] The FIFO isn't ALMOSTFULL !!!!!!!!"))
        end

        if(cnt == 1 && trans.almostempty)begin
            `uvm_info(get_type_name(),$sformatf("The FIFO is ALMOSTEMPTY"), UVM_LOW)
            `uvm_info(get_type_name(),$sformatf("Element of FIFO = %0d",cnt), UVM_LOW)
        end else if((cnt == 1) !== (trans.almostempty)) begin
            `uvm_error(get_type_name(),$sformatf("[FAILD] The FIFO isn't ALMOSTEMPTY !!!!!!!!!"))
        end

        if(cnt == 8 && trans.wr_en && trans.overflow)begin
            `uvm_info(get_type_name(),$sformatf("The FIFO is OVERFLOW"), UVM_LOW)
            `uvm_info(get_type_name(),$sformatf("Element of FIFO = %0d",cnt), UVM_LOW)
        end else if((cnt == 8 && trans.wr_en) !== (trans.overflow)) begin
            `uvm_error(get_type_name(),$sformatf("[FAILD] The FIFO isn't OVERFLOW !!!!!!!"))
        end
        
        if(cnt == 0 &&  trans.rd_en && trans.underflow)begin
            `uvm_info(get_type_name(),$sformatf("The FIFO is UNDERFLOW"), UVM_LOW)
            `uvm_info(get_type_name(),$sformatf("Element of FIFO = %0d",cnt), UVM_LOW)
        end else if((cnt == 0 && trans.rd_en) !== (trans.underflow)) begin
            `uvm_error(get_type_name(),$sformatf("[FAILD] The FIFO isn't UNDERFLOW !!!!!!"))
        end

        if(trans.wr_en && trans.wr_ack && cnt_pre < 8)begin
            exp_queue.push_front(trans);
            cnt++;
        end
        if(trans.rd_en && cnt_pre > 0)begin
            act_queue.push_front(trans);
            cnt--;
        end

    endfunction: write

    virtual task run_phase(uvm_phase phase);
        forever begin
            fifo_transaction in;
            fifo_transaction out;
         
            wait( (exp_queue.size()>0) && (act_queue.size()>0));
            in = exp_queue.pop_back();
            out= act_queue.pop_back();
            
            if(in.data_in == out.data_out) begin
                `uvm_info(get_type_name(),$sformatf("[PASS] act = %0h exp = %0h",out.data_out,in.data_in), UVM_LOW)
            end else begin
                `uvm_error(get_type_name(),$sformatf("[FAIL] act = %0h exp = %0h !!!!!!!!",out.data_out,in.data_in))
            end
        end
    endtask: run_phase
endclass: fifo_scoreboard

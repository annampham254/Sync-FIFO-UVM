class base_test extends uvm_test;
    `uvm_component_utils(base_test)
    virtual fifo_if fifo_vif;
    fifo_env env;
    

    function new(string name = "base_test", uvm_component parent);
        super.new(name,parent);
    endfunction: new
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("build_phase","Entered...",UVM_LOW)

        if(!uvm_config_db#(virtual fifo_if)::get(this,"","fifo_vif",fifo_vif))begin
            `uvm_fatal(get_type_name(),$sformatf("Failed to get fifo vif from config db!!!!!!!!"))
        end

        env = fifo_env :: type_id :: create("env",this);
        
        uvm_config_db#(virtual fifo_if)::set(this,"env","fifo_vif",fifo_vif);

        `uvm_info("build_phase","Exiting...",UVM_LOW)
    endfunction: build_phase

    virtual function void start_of_simulation_phase(uvm_phase phase);
        uvm_top.print_topology();
    endfunction

    //regress
    virtual function void report_phase(uvm_phase phase);
        uvm_report_server svr;
        int num_error, num_fatal;
        svr       = uvm_report_server::get_server();
        num_error = svr.get_severity_count(UVM_ERROR); 
        num_fatal = svr.get_severity_count(UVM_FATAL);
        `uvm_info(get_type_name(),"==========================================================================",UVM_NONE)
        if(num_error == 0 && num_fatal == 0 )begin
            `uvm_info(get_type_name(),"                         TEST PASSED", UVM_NONE)
        end else begin
            `uvm_error(get_type_name(),"                        TEST FAILED")
        end
        `uvm_info(get_type_name(),"==========================================================================",UVM_NONE)
    endfunction: report_phase
endclass: base_test

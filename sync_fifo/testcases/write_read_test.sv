class write_read_test extends base_test;
    `uvm_component_utils(write_read_test)
    write_sequence write_seq;
    read_sequence  read_seq;

    function new(string name = "write_read_test", uvm_component parent);
        super.new(name,parent);
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
       
        write_seq = write_sequence :: type_id :: create ("write_seq",this);
        write_seq.num_item = 8;
        write_seq.start(env.agent.sequencer);

        repeat (1) @(posedge fifo_vif.clk);
        
        read_seq = read_sequence :: type_id :: create ("read_seq",this);
        read_seq.num_item = 8;
        read_seq.start(env.agent.sequencer);

        repeat (3) @(posedge fifo_vif.clk);
        phase.drop_objection(this);
    endtask: run_phase
endclass: write_read_test

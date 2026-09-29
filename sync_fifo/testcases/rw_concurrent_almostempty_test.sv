class rw_concurrent_almostempty_test extends base_test;
    `uvm_component_utils(rw_concurrent_almostempty_test)
    concurrent_sequence write_read_seq;
    write_sequence write_seq;
    read_sequence read_seq;

    function new(string name = "rw_concurrent_almostempty_test", uvm_component parent);
        super.new(name,parent);
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        
        write_seq = write_sequence :: type_id :: create ("write_seq",this);
        write_seq.num_item = 1;
        write_seq.start(env.agent.sequencer);

        repeat (1) @(posedge fifo_vif.clk);

        write_read_seq = concurrent_sequence :: type_id :: create ("write_read_seq",this);
        write_read_seq.num_item = 1;
        write_read_seq.start(env.agent.sequencer);

        read_seq = read_sequence :: type_id :: create ("read_seq",this);
        read_seq.num_item = 1;
        read_seq.start(env.agent.sequencer);

        

        repeat (3) @(posedge fifo_vif.clk);
        phase.drop_objection(this);
    endtask: run_phase
endclass: rw_concurrent_almostempty_test

class almost_full_test extends base_test;
    `uvm_component_utils(almost_full_test)
    write_sequence write_seq;
    read_sequence  read_seq;

    function new(string name = "almost_full_test", uvm_component parent);
        super.new(name,parent);
    endfunction: new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        phase.raise_objection(this);
       
        write_seq = write_sequence :: type_id :: create ("write_seq",this);
        write_seq.num_item = 7;
        write_seq.start(env.agent.sequencer); 

        repeat (3) @(posedge fifo_vif.clk);
        phase.drop_objection(this);
    endtask: run_phase
endclass: almost_full_test

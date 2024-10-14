package FIFO_env_pack;
    import FIFO_Agent_pkg::*;
    import FIFO_Score_pkg::*;
    import FIFO_Cover_pkg::*;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    class FIFO_env extends uvm_env;
        `uvm_component_utils(FIFO_env) 

        FIFO_Agent_Class FIFO_agent_env;
        FIFO_Score_Class FIFO_Score_env;
        FIFO_Cover_Class FIFO_Cover_env;

        function new(string name = "FIFO_env", uvm_component parent = null);
            super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            FIFO_agent_env = FIFO_Agent_Class::type_id::create("FIFO_agent_env", this);
            FIFO_Score_env = FIFO_Score_Class::type_id::create("FIFO_Score_env", this);
            FIFO_Cover_env = FIFO_Cover_Class::type_id::create("FIFO_Cover_env", this);
        endfunction

        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            FIFO_agent_env.agt_ap.connect(FIFO_Score_env.sb_export);
            FIFO_agent_env.agt_ap.connect(FIFO_Cover_env.cov_export);
        endfunction
    endclass

endpackage

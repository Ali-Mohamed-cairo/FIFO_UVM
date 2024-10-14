package FIFO_Agent_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    
    import FIFO_SeqItem_pkg::*;
    import FIFO_Monitor_pkg::*;
    import FIFO_Config_Pack::*;
    import FIFO_Seqr_pkg::*;
    import FIFO_driver_pack::*;

    class FIFO_Agent_Class extends uvm_agent;
        `uvm_component_utils(FIFO_Agent_Class)

        uvm_analysis_port #(FIFO_SeqItem_Class) agt_ap;

        FIFO_Monitor_Class FIFO_monitor_agent;
        FIFO_Config_Class FIFO_congif_agent;
        FIFO_Seqr_Class FIFO_Seqr_agent;
        FIFO_driver FIFO_driver_agent;

        function new(string name = "FIFO_Agent_Class", uvm_component parent = null);
            super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            if(!(uvm_config_db #(FIFO_Config_Class)::get(this, "", "CFG", FIFO_congif_agent)))
                `uvm_fatal("build_phase", "Unable to get the configuration object")
            agt_ap = new("agt_ap", this);
            FIFO_Seqr_agent = FIFO_Seqr_Class::type_id::create("FIFO_Seqr_agent", this);
            FIFO_monitor_agent = FIFO_Monitor_Class::type_id::create("FIFO_monitor_agent", this);
            FIFO_driver_agent = FIFO_driver::type_id::create("FIFO_driver_agent", this);
        endfunction

        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            FIFO_driver_agent.seq_item_port.connect(FIFO_Seqr_agent.seq_item_export);
            FIFO_driver_agent.FIFO_driver_vif = FIFO_congif_agent.FIFO_config_vif;
            FIFO_monitor_agent.FIFO_monitor_vif = FIFO_congif_agent.FIFO_config_vif;
            FIFO_monitor_agent.mon_ap.connect(agt_ap);
        endfunction
    endclass
endpackage
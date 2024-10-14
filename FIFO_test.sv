package FIFO_test_pack;
    import FIFO_Write_Seq_pkg::*;
    import FIFO_Read_Seq_pkg::*;
    import FIFO_Write_Read_Seq_pkg::*;
    import FIFO_Reset_Seq_pkg::*;
    import FIFO_Config_Pack::*;
    import FIFO_env_pack::*;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    class FIFO_test extends uvm_test;
        `uvm_component_utils(FIFO_test)

        virtual FIFO_Interface FIFO_vif_test;
        FIFO_Config_Class FIFO_config_obj_test;
        FIFO_env env;
        FIFO_Reset_Seq_class reset_seq;
        FIFO_Write_Seq_class Write_seq;
        FIFO_Read_Seq_class Read_seq;
        FIFO_Write_Read_Seq_class Write_Read_seq;
        

        function new(string name = "FIFO_test", uvm_component parent = null);
            super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            env = FIFO_env::type_id::create("env", this);
            FIFO_config_obj_test = FIFO_Config_Class::type_id::create("FIFO_config_obj_test");
            Write_seq = FIFO_Write_Seq_class::type_id::create("Write_seq");
            reset_seq = FIFO_Reset_Seq_class::type_id::create("reset_seq");
            Read_seq = FIFO_Read_Seq_class::type_id::create("Read_seq");
            Write_Read_seq = FIFO_Write_Read_Seq_class::type_id::create("Write_Read_seq");

            if(!(uvm_config_db #(virtual FIFO_Interface)::get(this, "", "FIFO_IF", FIFO_config_obj_test.FIFO_config_vif)))
                `uvm_fatal("build_phase", "Test: Unable to get the virtual interface from uvm_config_db");
            uvm_config_db #(FIFO_Config_Class)::set(this, "*", "CFG", FIFO_config_obj_test);
        endfunction

        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            phase.raise_objection(this);
            /*Reset sequenece*/
            `uvm_info("run_phase", "Reset asserted", UVM_LOW)
            reset_seq.start(env.FIFO_agent_env.FIFO_Seqr_agent);
            `uvm_info("run_phase", "Reset Deasserted", UVM_LOW)
            
            /*Write sequence*/
            `uvm_info("run_phase", "Write stimulus generation", UVM_LOW)
            Write_seq.start(env.FIFO_agent_env.FIFO_Seqr_agent);
            `uvm_info("run_phase", "Write stimulus ended", UVM_LOW)

            /*Read sequence*/
            `uvm_info("run_phase", "Read stimulus generation", UVM_LOW)
            Read_seq.start(env.FIFO_agent_env.FIFO_Seqr_agent);
            `uvm_info("run_phase", "Read stimulus ended", UVM_LOW)

            /*Write/Read sequence*/
            `uvm_info("run_phase", "Write/Read stimulus generation", UVM_LOW)
            Write_Read_seq.start(env.FIFO_agent_env.FIFO_Seqr_agent);
            `uvm_info("run_phase", "Write/Read stimulus ended", UVM_LOW)
            phase.drop_objection(this);
        endtask

    endclass

endpackage
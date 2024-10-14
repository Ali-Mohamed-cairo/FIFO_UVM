package FIFO_Monitor_pkg;
    import FIFO_SeqItem_pkg::*;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    class FIFO_Monitor_Class extends uvm_monitor;
        `uvm_component_utils(FIFO_Monitor_Class)

        virtual FIFO_Interface FIFO_monitor_vif;
        FIFO_SeqItem_Class monitor_seq_item;
        uvm_analysis_port #(FIFO_SeqItem_Class) mon_ap;

        function new(string name = "FIFO_Monitor_Class", uvm_component parent = null);
            super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            mon_ap = new("mon_ap", this);
        endfunction

        

        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                monitor_seq_item = FIFO_SeqItem_Class::type_id::create("monitor_seq_item");
                @(negedge FIFO_monitor_vif.clk);

                monitor_seq_item.data_in = FIFO_monitor_vif.data_in;
                monitor_seq_item.rst_n = FIFO_monitor_vif.rst_n; 
                monitor_seq_item.wr_en = FIFO_monitor_vif.wr_en; 
                monitor_seq_item.rd_en = FIFO_monitor_vif.rd_en; 
                monitor_seq_item.data_out = FIFO_monitor_vif.data_out;
                monitor_seq_item.wr_ack = FIFO_monitor_vif.wr_ack;
                monitor_seq_item.overflow = FIFO_monitor_vif.overflow;
                monitor_seq_item.underflow = FIFO_monitor_vif.underflow;
                monitor_seq_item.full = FIFO_monitor_vif.full;
                monitor_seq_item.empty = FIFO_monitor_vif.empty;
                monitor_seq_item.almostfull = FIFO_monitor_vif.almostfull;
                monitor_seq_item.almostempty = FIFO_monitor_vif.almostempty;
                mon_ap.write(monitor_seq_item);
                `uvm_info("run_phase", monitor_seq_item.convert2string_stimulus(), UVM_HIGH)
            end
        endtask
    endclass
endpackage
package FIFO_Cover_pkg;
    import FIFO_SeqItem_pkg::*;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    class FIFO_Cover_Class extends uvm_component;
        `uvm_component_utils(FIFO_Cover_Class)

        uvm_analysis_export #(FIFO_SeqItem_Class) cov_export;
        uvm_tlm_analysis_fifo #(FIFO_SeqItem_Class) cov_fifo;

        FIFO_SeqItem_Class seq_item_cov;

        covergroup CVR;
            wr_en_CVR: coverpoint seq_item_cov.wr_en;
            rd_en_CVR: coverpoint seq_item_cov.rd_en;
            wr_ack_CVR: coverpoint seq_item_cov.wr_ack;
            overflow_CVR: coverpoint seq_item_cov.overflow;
            underflow_CVR: coverpoint seq_item_cov.underflow;
            full_CVR: coverpoint seq_item_cov.full;
            empty_CVR: coverpoint seq_item_cov.empty;
            almostfull_CVR: coverpoint seq_item_cov.almostfull;
            almostempty_CVR: coverpoint seq_item_cov.almostempty;
            cross wr_en_CVR, wr_ack_CVR;  cross wr_en_CVR, overflow_CVR; 
            cross wr_en_CVR, underflow_CVR;  cross wr_en_CVR, full_CVR;
            cross wr_en_CVR, empty_CVR;  cross wr_en_CVR, almostfull_CVR; cross wr_en_CVR, almostempty_CVR;
            cross rd_en_CVR, wr_ack_CVR;  cross rd_en_CVR, overflow_CVR; 
            cross rd_en_CVR, underflow_CVR;  cross rd_en_CVR, full_CVR;
            cross rd_en_CVR, empty_CVR;  cross rd_en_CVR, almostfull_CVR; cross rd_en_CVR, almostempty_CVR;
        endgroup

        function new(string name = "FIFO_Cover_Class", uvm_component parent = null);
            super.new(name, parent);
            CVR = new();
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            cov_export = new("cov_export", this);
            cov_fifo = new("cov_fifo", this);
        endfunction

        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            cov_export.connect(cov_fifo.analysis_export);
        endfunction

        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                cov_fifo.get(seq_item_cov);
                CVR.sample();
                //CVR.start();
            end
        endtask
    endclass
endpackage
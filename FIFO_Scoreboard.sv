package FIFO_Score_pkg;

    import FIFO_SeqItem_pkg::*;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    class FIFO_Score_Class extends uvm_scoreboard;
        `uvm_component_utils(FIFO_Score_Class)

        parameter FIFO_WIDTH = 16;
        parameter FIFO_DEPTH = 8;

        logic [FIFO_WIDTH-1:0] fifo_ref [$];
		integer fifo_count = 0;
		logic [FIFO_WIDTH-1:0] data_out_ref; 

        uvm_analysis_export #(FIFO_SeqItem_Class) sb_export;
        uvm_tlm_analysis_fifo #(FIFO_SeqItem_Class) sb_fifo;

        FIFO_SeqItem_Class seq_item_sb;

        int error_count = 0, correct_count = 0;

        function new(string name = "FIFO_Score_Class", uvm_component parent = null);
            super.new(name, parent);
        endfunction 

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            sb_export = new("sb_export", this);
            sb_fifo = new("sb_fifo", this);
        endfunction

        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            sb_export.connect(sb_fifo.analysis_export);
        endfunction

        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                sb_fifo.get(seq_item_sb);
                ref_model(seq_item_sb);
                #2;
                if((seq_item_sb.data_out == data_out_ref) || (^seq_item_sb.data_out === 1'bx)) begin
                    `uvm_info("run_phase", $sformatf("Success, DUT:%s", seq_item_sb.convert2string()), UVM_HIGH);
                    correct_count = correct_count + 1;
                end
                else begin
                   `uvm_error("run_phase", $sformatf("Failed, DUT:%s While the reference data_out_ref:%d", 
                               seq_item_sb.convert2string(), data_out_ref)); 
                    error_count = error_count + 1;
                end
            end
        endtask

        task ref_model(input FIFO_SeqItem_Class F_txn);
           if (!F_txn.rst_n) begin
                data_out_ref <=0;
				fifo_ref <= {};
				fifo_count = 0;
			end
			else begin
                if(F_txn.wr_en && F_txn.rd_en)
                    #2;
				if (F_txn.wr_en && fifo_count < F_txn.FIFO_DEPTH) begin
					fifo_ref.push_back(F_txn.data_in);
					fifo_count <= fifo_ref.size();
				end 

				if (F_txn.rd_en && fifo_count != 0) begin
					data_out_ref <= fifo_ref.pop_front();
					fifo_count <= fifo_ref.size();
				end 
			end
        endtask

        function void report_phase(uvm_phase phase);
            super.report_phase(phase);
            `uvm_info("report_phase", $sformatf("Total success(correct_count) = %d", correct_count), UVM_MEDIUM);
            `uvm_info("report_phase", $sformatf("Total Failed(error_count) = %d", error_count), UVM_MEDIUM);
        endfunction
    endclass 
endpackage
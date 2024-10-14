package FIFO_Seqr_pkg;
    import FIFO_SeqItem_pkg::*;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    class FIFO_Seqr_Class extends uvm_sequencer #(FIFO_SeqItem_Class);
        `uvm_component_utils(FIFO_Seqr_Class)

        function new(string name = "FIFO_Seqr_Class", uvm_component parent = null);
            super.new(name, parent);
        endfunction
    endclass
endpackage

package FIFO_SeqItem_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    class FIFO_SeqItem_Class extends uvm_sequence_item;
        `uvm_object_utils(FIFO_SeqItem_Class)
        
        parameter FIFO_WIDTH = 16;
        parameter FIFO_DEPTH = 8;
        rand logic [FIFO_WIDTH-1:0] data_in;
        bit rst_n, wr_en, rd_en;
        logic [FIFO_WIDTH-1:0] data_out;
        bit wr_ack, overflow, underflow, full, empty, almostfull, almostempty;
        int RD_EN_ON_DIST = 30;
        int WR_EN_ON_DIST = 70;

        function new(string name = "FIFO_SeqItem_Class");
            super.new(name);
        endfunction

        function string convert2string();
            return $sformatf("%s rst_n = 0b%0b, wr_en = 0b%0b, rd_en = 0b%0b, and data_out = %d", super.convert2string(),
            rst_n, wr_en, rd_en, data_out);
        endfunction

        function string convert2string_stimulus();
            return $sformatf("rst_n = 0b%0b, wr_en = 0b%0b, rd_en = 0b%0b, and data_out = %d", rst_n, wr_en, rd_en, data_out);
        endfunction

        constraint rst_C{rst_n dist {0:/2, 1:/98};}
        constraint wr_en_C{wr_en dist {0:/(100-WR_EN_ON_DIST), 1:/WR_EN_ON_DIST};}
        constraint rd_en_C{rd_en dist {0:/(100-RD_EN_ON_DIST), 1:/RD_EN_ON_DIST};}
    endclass
endpackage
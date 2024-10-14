package FIFO_Read_Seq_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    import FIFO_SeqItem_pkg::*;

    class FIFO_Read_Seq_class extends uvm_sequence #(FIFO_SeqItem_Class);
        `uvm_object_utils(FIFO_Read_Seq_class)

        FIFO_SeqItem_Class Read_Seq_Item;

        function new(string name = "FIFO_Read_Seq_class");
            super.new(name);
        endfunction

        task body();
            repeat(4000) begin
                Read_Seq_Item = FIFO_SeqItem_Class::type_id::create("Read_Seq_Item");
                start_item(Read_Seq_Item);
                Read_Seq_Item.rst_n = 1;
                Read_Seq_Item.wr_en = 0;
                Read_Seq_Item.rd_en = 1;
                assert(Read_Seq_Item.randomize());
                finish_item(Read_Seq_Item);
            end
        endtask
    endclass
endpackage
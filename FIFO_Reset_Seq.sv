package FIFO_Reset_Seq_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    import FIFO_SeqItem_pkg::*;

    class FIFO_Reset_Seq_class extends uvm_sequence #(FIFO_SeqItem_Class);
        `uvm_object_utils(FIFO_Reset_Seq_class)

        FIFO_SeqItem_Class Rst_Seq_Item;

        function new(string name = "FIFO_Reset_Seq_class");
            super.new(name);
        endfunction

        task body();
           Rst_Seq_Item = FIFO_SeqItem_Class::type_id::create("Rst_Seq_Item");
           start_item(Rst_Seq_Item);
           Rst_Seq_Item.rst_n = 0;
           Rst_Seq_Item.wr_en = 1; 
           Rst_Seq_Item.rd_en = 1; 
           Rst_Seq_Item.data_in = 12;
           finish_item(Rst_Seq_Item);
        endtask
    endclass
endpackage
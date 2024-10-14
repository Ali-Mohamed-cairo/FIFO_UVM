package FIFO_Write_Read_Seq_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    import FIFO_SeqItem_pkg::*;

    class FIFO_Write_Read_Seq_class extends uvm_sequence #(FIFO_SeqItem_Class);
        `uvm_object_utils(FIFO_Write_Read_Seq_class)

        FIFO_SeqItem_Class Write_Read_Seq_Item;

        function new(string name = "FIFO_Write_Read_Seq_class");
            super.new(name);
        endfunction

        task body();
            repeat(10) begin
                Write_Read_Seq_Item = FIFO_SeqItem_Class::type_id::create("Write_Read_Seq_Item");
                start_item(Write_Read_Seq_Item);
                Write_Read_Seq_Item.rst_n = 1;
                Write_Read_Seq_Item.wr_en = 1;
                Write_Read_Seq_Item.rd_en = 1;
                assert(Write_Read_Seq_Item.randomize());
                finish_item(Write_Read_Seq_Item);
            end
        endtask
    endclass
endpackage
package FIFO_driver_pack;
    import FIFO_SeqItem_pkg::*;
    import FIFO_Config_Pack::*;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    class FIFO_driver extends uvm_driver #(FIFO_SeqItem_Class);
        `uvm_component_utils(FIFO_driver)


        virtual FIFO_Interface FIFO_driver_vif;
        FIFO_SeqItem_Class Seq_Item;

        function new(string name = "FIFO_driver", uvm_component parent = null);
            super.new(name, parent);
        endfunction

        

        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                Seq_Item = FIFO_SeqItem_Class::type_id::create("Seq_Item");
                seq_item_port.get_next_item(Seq_Item);
                FIFO_driver_vif.rst_n = Seq_Item.rst_n;
                FIFO_driver_vif.data_in = Seq_Item.data_in; 
                FIFO_driver_vif.wr_en = Seq_Item.wr_en; 
                FIFO_driver_vif.rd_en = Seq_Item.rd_en; 
                @(negedge FIFO_driver_vif.clk);
                seq_item_port.item_done();
                `uvm_info("run_phase", Seq_Item.convert2string_stimulus(), UVM_HIGH);
            end
        endtask
    endclass 
    
endpackage
package FIFO_Config_Pack;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    class FIFO_Config_Class extends uvm_object;
        `uvm_object_utils(FIFO_Config_Class)

        virtual FIFO_Interface FIFO_config_vif;

        function new(string name = "FIFO_Config_Class");
            super.new(name);
        endfunction
    endclass
endpackage
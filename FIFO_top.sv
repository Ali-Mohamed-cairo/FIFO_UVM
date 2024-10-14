import FIFO_test_pack::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

module FIFO_top();

bit clk;

initial begin
    clk = 1;
    forever #1 clk = ~clk; 
end

FIFO_Interface FIFO_inter(clk);

FIFO fifo_DUT(FIFO_inter);

bind FIFO FIFO_SVA SVA(FIFO_inter.DUT);

initial begin
    uvm_config_db#(virtual FIFO_Interface)::set(null, "uvm_test_top", "FIFO_IF", FIFO_inter);
    run_test("FIFO_test"); 
end

endmodule
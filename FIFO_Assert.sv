module ALSU_Assert(ALSU_inter_arb.Assert ALSU_inter);

assert property (@(negedge ALSU_inter.clk) (ALSU_inter.rst |-> (!(ALSU_inter.leds) & !(ALSU_inter.out))));

assert property (@(negedge ALSU_inter.clk) 
                (((ALSU_inter.red_op_A | ALSU_inter.red_op_B) & (ALSU_inter.opcode[1] | ALSU_inter.opcode[2]) | (ALSU_inter.opcode[1] & ALSU_inter.opcode[2]))
                 |-> (!ALSU_inter.out & !($past(ALSU_inter.leds)))));


endmodule
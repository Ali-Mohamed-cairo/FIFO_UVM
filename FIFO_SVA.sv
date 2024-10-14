module FIFO_SVA(FIFO_Interface.DUT FIFO_Inter);

assert property (@(posedge FIFO_Inter.clk) ((FIFO.count == FIFO.FIFO_DEPTH) |-> FIFO_Inter.full));
cover property (@(posedge FIFO_Inter.clk) ((FIFO.count == FIFO.FIFO_DEPTH) |-> FIFO_Inter.full));

assert property (@(posedge FIFO_Inter.clk) ((FIFO.count == 0) |-> FIFO_Inter.empty));
cover property (@(posedge FIFO_Inter.clk) ((FIFO.count == 0) |-> FIFO_Inter.empty));

assert property (@(posedge FIFO_Inter.clk) ((FIFO.count == FIFO.FIFO_DEPTH-1) |-> FIFO_Inter.almostfull));
cover property (@(posedge FIFO_Inter.clk) ((FIFO.count == FIFO.FIFO_DEPTH-1) |-> FIFO_Inter.almostfull));

assert property (@(posedge FIFO_Inter.clk) ((FIFO.count == 1) |-> FIFO_Inter.almostempty));
cover property (@(posedge FIFO_Inter.clk) ((FIFO.count == 1) |-> FIFO_Inter.almostempty));

assert property (@(posedge FIFO_Inter.clk) ((FIFO_Inter.full & FIFO_Inter.wr_en) |=> FIFO_Inter.overflow));
cover property (@(posedge FIFO_Inter.clk) ((FIFO_Inter.full & FIFO_Inter.wr_en) |=> FIFO_Inter.overflow));

assert property (@(posedge FIFO_Inter.clk) ((FIFO_Inter.empty & FIFO_Inter.rd_en) |=> FIFO_Inter.underflow));
cover property (@(posedge FIFO_Inter.clk) ((FIFO_Inter.empty & FIFO_Inter.rd_en) |=> FIFO_Inter.underflow));

assert property (@(posedge FIFO_Inter.clk) ((FIFO_Inter.wr_en && (FIFO.count < FIFO.FIFO_DEPTH)) |=> FIFO_Inter.wr_ack));
cover property (@(posedge FIFO_Inter.clk) ((FIFO_Inter.wr_en && (FIFO.count < FIFO.FIFO_DEPTH)) |=> FIFO_Inter.wr_ack));

assert property (@(posedge FIFO_Inter.clk) ((!FIFO_Inter.rst_n) |=> ((!FIFO.wr_ptr) & (!FIFO.rd_ptr) & (!FIFO.count))));
cover property (@(posedge FIFO_Inter.clk) ((!FIFO_Inter.rst_n) |=> ((!FIFO.wr_ptr) & (!FIFO.rd_ptr) & (!FIFO.count))));

endmodule
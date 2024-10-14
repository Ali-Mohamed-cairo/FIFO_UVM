interface FIFO_Interface(clk);
    parameter FIFO_WIDTH = 16;
    parameter FIFO_DEPTH = 8;
    input bit clk;
    logic [FIFO_WIDTH-1:0] data_in, data_out;
    bit rst_n, wr_en, rd_en, wr_ack, overflow, underflow, full, empty, almostfull, almostempty;

    modport DUT(input clk, rst_n, data_in, wr_en, rd_en,
                output data_out, wr_ack, overflow, underflow, full, empty, almostfull, almostempty);

endinterface
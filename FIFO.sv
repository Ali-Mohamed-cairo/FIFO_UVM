////////////////////////////////////////////////////////////////////////////////
// Author: Kareem Waseem
// Course: Digital Verification using SV & UVM
//
// Description: FIFO Design 
// 
////////////////////////////////////////////////////////////////////////////////
module FIFO(FIFO_Interface.DUT FIFO_Inter);
parameter FIFO_WIDTH = 16;
parameter FIFO_DEPTH = 8;

localparam max_fifo_addr = $clog2(FIFO_DEPTH);

reg [FIFO_WIDTH-1:0] mem [FIFO_DEPTH-1:0];

reg [max_fifo_addr-1:0] wr_ptr, rd_ptr;
reg [max_fifo_addr:0] count; //True because count must count from 1 to FIFO_DEPTH not (FIFO_DEPTH-1)

always @(posedge FIFO_Inter.clk or negedge FIFO_Inter.rst_n) begin
	if (!FIFO_Inter.rst_n) begin
		wr_ptr <= 0;
		FIFO_Inter.overflow <= 0;
		FIFO_Inter.wr_ack <= 0;
	end
	else if (FIFO_Inter.wr_en && (count < FIFO_DEPTH)) begin
		mem[wr_ptr] <= FIFO_Inter.data_in;
		FIFO_Inter.wr_ack <= 1;
		wr_ptr <= wr_ptr + 1;
	end
	else begin 
		FIFO_Inter.wr_ack <= 0; 
		if (FIFO_Inter.full & FIFO_Inter.wr_en)
			FIFO_Inter.overflow <= 1;
		else
			FIFO_Inter.overflow <= 0;
	end
end

always @(posedge FIFO_Inter.clk or negedge FIFO_Inter.rst_n) begin
	if (!FIFO_Inter.rst_n) begin
		FIFO_Inter.data_out <= 0; 
		rd_ptr <= 0;
		FIFO_Inter.underflow <= 0;
	end
	else if (FIFO_Inter.rd_en && (count != 0)) begin
		FIFO_Inter.data_out <= mem[rd_ptr];
		rd_ptr <= rd_ptr + 1;
	end
	else begin
		if (FIFO_Inter.empty & FIFO_Inter.rd_en)
			FIFO_Inter.underflow <= 1;
		else
			FIFO_Inter.underflow <= 0;
	end
end

always @(posedge FIFO_Inter.clk or negedge FIFO_Inter.rst_n) begin
	if (!FIFO_Inter.rst_n) begin
		count <= 0;
	end
	else begin
		if	( ({FIFO_Inter.wr_en, FIFO_Inter.rd_en} == 2'b10) && (!FIFO_Inter.full)) 
			count <= count + 1;
		else if ( ({FIFO_Inter.wr_en, FIFO_Inter.rd_en} == 2'b01) && (!FIFO_Inter.empty))
			count <= count - 1;
		else if(({FIFO_Inter.wr_en, FIFO_Inter.rd_en} == 2'b11)) begin
			if(count < FIFO_DEPTH)
				count <= count + 1;
			if(count != 0)
				count <= count - 1;
		end
	end
end

assign FIFO_Inter.full = (count == FIFO_DEPTH)? 1 : 0;
assign FIFO_Inter.empty = (count == 0)? 1 : 0;
assign FIFO_Inter.almostfull = (count == FIFO_DEPTH-1)? 1 : 0; 
assign FIFO_Inter.almostempty = (count == 1)? 1 : 0;

endmodule
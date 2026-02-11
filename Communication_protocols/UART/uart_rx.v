//////////////////////////////////////////////////////////////////////////////////
// Company: KLE Technological Univeristy Hubli
// Engineer: Vinayak Todakar
// 
// Create Date: 09.02.2026 11:50:45 AM
// Design Name: uart Reciever
// Module Name: uart_reciever
// Project Name: UART Protocol 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uart_reciever(input clk,rst,rx,rdy_clr,clken,output reg  rdy,output reg [7:0] data_out);

always@(posedge clk)
    if(rst) begin
        rdy = 0;
        data_out = 0;
        
        
        end
        
        
        parameter start_state	= 2'b00;
parameter RX_STATE_data_out		= 2'b01;
parameter stop_state		= 2'b10;

reg [1:0] state = start_state;
reg [3:0] sample = 0;
reg [3:0] index = 0;
reg [7:0] temp = 8'b0;


always @(posedge clk) begin
	if (rdy_clr)
		rdy <= 0;

	if (clken) begin
		case (state)
		start_state: begin
			/*
			* Start counting from the first low sample, once we've
			* sampled a full bit, start collecting data_out bits.
			*/
			if (!rx || sample != 0)
				sample <= sample + 4'b1;

			if (sample == 15) begin
				state <= RX_STATE_data_out;
				index <= 0;
				sample <= 0;
				//scratch <= 0;
			end
		end
		RX_STATE_data_out: begin
			sample <= sample + 4'b1;
			if (sample == 4'h8) begin
				temp[index] <= rx;
				index <= index + 4'b1;
			end
			if (index == 8 && sample == 15)
				state <= stop_state;
		end
		stop_state: begin
			/*
			 * Our baud clock may not be running at exactly the
			 * same rate as the transmitter.  If we thing that
			 * we're at least half way into the stop bit, allow
			 * transition into handling the next start bit.
			 */
			if (sample == 15 ) begin
				state <= start_state;
				//data_out <= scratch;
				data_out <= temp;
				rdy <= 1'b1;
				sample <= 0;
			end else begin
				sample <= sample + 4'b1;
			end
		end
		default: begin
			state <= start_state;
		end
		endcase
	end
end

endmodule
        

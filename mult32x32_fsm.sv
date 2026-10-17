// 32X32 Multiplier FSM
module mult32x32_fsm (
    input logic clk,              // Clock
    input logic reset,            // Reset
    input logic start,            // Start signal
    output logic busy,            // Multiplier busy indication
    output logic [1:0] a_sel,     // Select one byte from A
    output logic b_sel,           // Select one 2-byte word from B
    output logic [2:0] shift_sel, // Select output from shifters
    output logic upd_prod,        // Update the product register
    output logic clr_prod         // Clear the product register
);


	typedef enum { idle, sum1,  sum2, sum3, sum4, sum5, sum6, sum7, sum8} state;
	state current_state;
	state next_state;
	
	always_comb begin
		next_state = current_state;
		busy = 1'b1;
		a_sel = 2'd0;
		b_sel = 1'b0;
		shift_sel = 2'd0;
		clr_prod = 1'b0;
		upd_prod = 1'b0;
		
			case (current_state)
				idle: begin
					busy = 1'b0;
					a_sel = 2'd0;
					b_sel = 1'b0;
					shift_sel = 3'd0;
					clr_prod = 1'b0;
					upd_prod = 1'b0;
					if (start == 1'b1) begin
						clr_prod = 1'b1;
						next_state = sum1;
					end
					else begin
						next_state = idle;
					end
				end
				
				sum1: begin
					next_state = sum2;
					busy = 1'b1;
					a_sel = 2'd0;
					b_sel = 1'b0;
					shift_sel = 3'd0;
					clr_prod = 1'b0;
					upd_prod = 1'b1;
				end
				sum2: begin
					next_state = sum3;
					busy = 1'b1;
					a_sel = 2'd1;
					b_sel = 1'b0;
					shift_sel = 3'd1;
					clr_prod = 1'b0;
					upd_prod = 1'b1;
				end
				sum3: begin
					next_state = sum4;
					busy = 1'b1;
					a_sel = 2'd2;
					b_sel = 1'b0;
					shift_sel =3'd2;
					clr_prod = 1'b0;
					upd_prod = 1'b1;
				end
				
				sum4: begin
					next_state = sum5;
					busy = 1'b1;
					a_sel = 2'd3;
					b_sel = 1'b0;
					shift_sel = 3'd3;
					clr_prod = 1'b0;
					upd_prod = 1'b1;
				end
				sum5: begin
					next_state = sum6;
					busy = 1'b1;
					a_sel = 2'd0;
					b_sel = 1'b1;
					shift_sel = 3'd2;
					clr_prod = 1'b0;
					upd_prod = 1'b1;
				end
				sum6: begin
					next_state = sum7;
					busy = 1'b1;
					a_sel = 2'd1;
					b_sel = 1'b1;
					shift_sel = 3'd3;
					clr_prod = 1'b0;
					upd_prod = 1'b1;
				end
				sum7: begin
					next_state = sum8;
					busy = 1'b1;
					a_sel = 2'd2;
					b_sel = 1'b1;
					shift_sel = 3'd4;
					clr_prod = 1'b0;
					upd_prod = 1'b1;
				end
				sum8: begin
					next_state = idle;
					busy = 1'b1;
					a_sel = 2'd3;
					b_sel = 1'b1;
					shift_sel = 3'd5;
					clr_prod = 1'b0;
					upd_prod = 1'b1;
				end
				
				default: begin
				next_state = idle;
				end
		endcase
	end
	

	always_ff @(posedge clk, posedge reset) begin
			if (reset == 1'b1) begin
			current_state <= idle;
			end
			else begin
			current_state <= next_state;
			end
		end


endmodule

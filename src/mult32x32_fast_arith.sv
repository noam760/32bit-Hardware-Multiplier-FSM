// 32X32 Multiplier arithmetic unit template
module mult32x32_fast_arith (
    input logic clk,             // Clock
    input logic reset,           // Reset
    input logic [31:0] a,        // Input a
    input logic [31:0] b,        // Input b
    input logic [1:0] a_sel,     // Select one byte from A
    input logic b_sel,           // Select one 2-byte word from B
    input logic [2:0] shift_sel, // Select output from shifters
    input logic upd_prod,        // Update the product register
    input logic clr_prod,        // Clear the product register
    output logic a_msb_is_0,     // Indicates MSB of operand A is 0
    output logic b_msw_is_0,     // Indicates MSW of operand B is 0
    output logic [63:0] product  // Miltiplication product
);

// Put your code here
// ------------------
	logic [7:0]mux_a;
	logic [15:0]mux_b;
	logic [23:0] multi_sum;
	logic [63:0] shift_out;
	
	logic [63:0] adder_out;
	logic [63:0] product_register_out;


	always_comb begin
	
	if(a[31:24]==8'd0)begin
		a_msb_is_0 = 1'b1;
		end 
	else begin 
		a_msb_is_0 = 1'b0;
		end
		
	
	if(b[31:16]==16'd0)begin
		b_msw_is_0 = 1'b1;
		end 
	else begin 
		b_msw_is_0 = 1'b0;
		end
		
	
	
	case (a_sel)
		2'd0:begin
			mux_a = a[7:0];
		end
		2'd1:begin
			mux_a = a[15:8];
		end
		2'd2:begin
			mux_a = a[23:16];
		end
		2'd3:begin
			mux_a = a[31:24];
		end
		default:
		mux_a = a[31:24];
	endcase
	
	case (b_sel)
		1'd0:begin
			mux_b = b[15:0];
		end
		1'd1:begin
			mux_b = b[31:16];
		end
		
		default:
		mux_b = b[31:16];
	endcase
	
	multi_sum = mux_a *  mux_b;
	
	case (shift_sel)
            3'd0: shift_out = {40'd0, multi_sum} << 0;
            3'd1: shift_out = {40'd0, multi_sum} << 8;
            3'd2: shift_out = {40'd0, multi_sum} << 16;
            3'd3: shift_out = {40'd0, multi_sum} << 24;
            3'd4: shift_out = {40'd0, multi_sum} << 32;
            3'd5: shift_out = {40'd0, multi_sum} << 40;
            default: shift_out = 64'd0;
        endcase
		
		adder_out = shift_out + product_register_out;
		
		
		product = product_register_out;
			
	
	end
	
	


	always_ff @(posedge clk, posedge reset) begin
			if (reset == 1'b1) begin
				product_register_out <= 64'b0;
			end
			else if (clr_prod == 1'b1) begin
				product_register_out <= 64'b0;
			end
			else begin
				if(upd_prod == 1'b1)begin
					product_register_out <= adder_out;
				end
			end
		end

// End of your code

endmodule

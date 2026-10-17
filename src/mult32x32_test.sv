// 32X32 Multiplier test template
module mult32x32_test;

    logic clk;            // Clock
    logic reset;          // Reset
    logic start;          // Start signal
    logic [31:0] a;       // Input a
    logic [31:0] b;       // Input b
    logic busy;           // Multiplier busy indication
    logic [63:0] product; // Miltiplication product


// Put your code here
// ------------------

mult32x32 mul(
	.clk(clk),
	.reset(reset),
	.start(start),
	.a(a),
	.b(b),
	.busy(busy),
	.product(product)
);

always begin
#10 clk = ~clk;
end

initial begin 
		clk = 0; 
        start = 0;
        reset = 1;
		a = 32'd0;
        b = 32'd0;
	repeat(4) begin
		@(posedge clk);
	end
	reset = 0;
	a = 32'd210041257; 
	b = 32'd325405611;
	
	@(posedge clk);
	start = 1;
	@(posedge clk);	
	start = 0;
	
        wait(busy == 1'b0);
        
        repeat(2) begin
            @(posedge clk);
        end
        
 
        $stop;

end






// End of your code

endmodule

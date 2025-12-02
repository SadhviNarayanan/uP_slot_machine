// Name: Sadhvi Narayanan
// Email: sanarayanan@g.hmc.edu

module select_toggle(
	input logic clk,
	input logic reset_n,
	output logic [2:0] freq_counter
);

  logic [23:0] counter;

  // For 25MHz clock and 5 displays at 60Hz each:
  // 25,000,000 / (60 * 5) = 83,333 cycles per display
  localparam CYCLES_PER_DISPLAY = 83333;
  
  // clock is toggling at 60Hz
  always_ff @(posedge clk, negedge reset_n) begin
    if(reset_n == 0) begin
      counter <= 0;
      freq_counter <= 0;
    end else if (counter == CYCLES_PER_DISPLAY - 1) begin
      counter <= 0;

      if (freq_counter == 3'd4) begin
        freq_counter <= 0;
      end else begin
        freq_counter <= freq_counter + 1;  // increments the ouput to create 60Hz frequency
      end
   end else begin
      counter <= counter + 1;
   end
  end
    
 
endmodule

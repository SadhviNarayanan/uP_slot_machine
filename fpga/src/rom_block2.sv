module rom_block2  #(
    // HSOSC divider: "0b00"=48, "0b01"=24, "0b10"=12, "0b11"=6 MHz
    parameter string text_file
) (
    input  logic clk,
    input  logic [7:0] address,
	output logic [15:0] rgb
);
	localparam SPRITE_WIDTH = 64;
    localparam DATA_WIDTH = 16;
    localparam TOTAL_WORDS = 256; // 7168 words total
    localparam ADDRESS_WIDTH = 8;        // 13 bits for 7168 words
    
	(* ram_style = "block" *) 
    logic [DATA_WIDTH-1:0] single_bram1 [0:TOTAL_WORDS-1]; 


    // NOTE: need a file with "all_sprites_combined.mem" (7168 lines) --> should have all the sprites in 1 hopefully it uses 28 bram blcocks
    initial begin 
		$readmemh(text_file, single_bram1);
    end

	always_ff @(posedge clk) begin 
		rgb      <= single_bram1[address]; 
	end


endmodule

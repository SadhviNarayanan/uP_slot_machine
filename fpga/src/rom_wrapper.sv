// color_sprite_rom.sv - Updated for 7 Sprites

module rom_wrapper (
    input  logic clk,
    input  logic [2:0] sprite_sel_i,  // Sprite index (0-6)
    input  logic [9:0] word_addr_i,   // 10-bit word address (0-1023)
    output logic [15:0] data_o        // 16-bit word output (4 color pixels)
);

    // --- Address Decoding ---
    logic [1:0] bram_select; // word_addr_i[9:8]: Selects which of the 4 BRAMs
    logic [7:0] bram_addr;   // word_addr_i[7:0]: 8-bit address within the BRAM

    assign bram_select = word_addr_i[9:8];
    assign bram_addr   = word_addr_i[7:0];

    // --- BRAM Output Wires ---
    // Wires organized by sprite index (s0 to s6) and BRAM index (b0 to b3)
    
    // Wires for Sprite 0 (s0)
    logic [15:0] s0_bram0_data, s0_bram1_data, s0_bram2_data, s0_bram3_data;
    // Wires for Sprite 1 (s1)
    logic [15:0] s1_bram0_data, s1_bram1_data, s1_bram2_data, s1_bram3_data;
    // Wires for Sprite 2 (s2)
    logic [15:0] s2_bram0_data, s2_bram1_data, s2_bram2_data, s2_bram3_data;
    // Wires for Sprite 3 (s3)
    logic [15:0] s3_bram0_data, s3_bram1_data, s3_bram2_data, s3_bram3_data;
    // Wires for Sprite 4 (s4)
    logic [15:0] s4_bram0_data, s4_bram1_data, s4_bram2_data, s4_bram3_data;
    // Wires for Sprite 5 (s5)
    logic [15:0] s5_bram0_data, s5_bram1_data, s5_bram2_data, s5_bram3_data;
    // Wires for Sprite 6 (s6)
    logic [15:0] s6_bram0_data, s6_bram1_data, s6_bram2_data, s6_bram3_data;
    
    // --- BRAM Instantiations (28 Total) ---
    // You must ensure the memory files (e.g., "sprite6_bram3.mem") exist and contain the correct split data.
	
	
    // Sprite 0 (4 BRAMs)
    rom_block2 #( .text_file("/Users/sanarayanan/my_designs/Slot_Machine_Final/source/impl_1/sprite_rom0.mem") ) s0_bram0_inst (.clk(clk), .address(bram_addr), .rgb(s0_bram0_data) );
    rom_block2 #( .text_file("/Users/sanarayanan/my_designs/Slot_Machine_Final/source/impl_1/sprite_rom1.mem") ) s0_bram1_inst (.clk(clk), .address(bram_addr), .rgb(s0_bram1_data) );
    rom_block2 #( .text_file("/Users/sanarayanan/my_designs/Slot_Machine_Final/source/impl_1/sprite_rom2.mem") ) s0_bram2_inst (.clk(clk), .address(bram_addr), .rgb(s0_bram2_data) );
    rom_block2 #( .text_file("/Users/sanarayanan/my_designs/Slot_Machine_Final/source/impl_1/sprite_rom3.mem") ) s0_bram3_inst (.clk(clk), .address(bram_addr), .rgb(s0_bram3_data) );
    
    // Sprite 1 (4 BRAMs)
    rom_block2 #( .text_file("/Users/sanarayanan/my_designs/Slot_Machine_Final/source/impl_1/sprite_rom0.mem") ) s1_bram0_inst (.clk(clk), .address(bram_addr), .rgb(s1_bram0_data) );
    rom_block2 #( .text_file("/Users/sanarayanan/my_designs/Slot_Machine_Final/source/impl_1/sprite_rom1.mem") ) s1_bram1_inst (.clk(clk), .address(bram_addr), .rgb(s1_bram1_data) );
    rom_block2 #( .text_file("/Users/sanarayanan/my_designs/Slot_Machine_Final/source/impl_1/sprite_rom2.mem") ) s1_bram2_inst (.clk(clk), .address(bram_addr), .rgb(s1_bram2_data) );
    rom_block2 #( .text_file("/Users/sanarayanan/my_designs/Slot_Machine_Final/source/impl_1/sprite_rom3.mem") ) s1_bram3_inst (.clk(clk), .address(bram_addr), .rgb(s1_bram3_data) );

    // Sprite 2 (4 BRAMs)
    rom_block2 #( .text_file("/Users/sanarayanan/my_designs/Slot_Machine_Final/source/impl_1/sprite_rom0.mem") ) s2_bram0_inst (.clk(clk), .address(bram_addr), .rgb(s2_bram0_data) );
    rom_block2 #( .text_file("/Users/sanarayanan/my_designs/Slot_Machine_Final/source/impl_1/sprite_rom1.mem") ) s2_bram1_inst (.clk(clk), .address(bram_addr), .rgb(s2_bram1_data) );
    rom_block2 #( .text_file("/Users/sanarayanan/my_designs/Slot_Machine_Final/source/impl_1/sprite_rom2.mem") ) s2_bram2_inst (.clk(clk), .address(bram_addr), .rgb(s2_bram2_data) );
    rom_block2 #( .text_file("/Users/sanarayanan/my_designs/Slot_Machine_Final/source/impl_1/sprite_rom3.mem") ) s2_bram3_inst (.clk(clk), .address(bram_addr), .rgb(s2_bram3_data) );

    // Sprite 3 (4 BRAMs)
    rom_block2 #( .text_file("/Users/sanarayanan/my_designs/Slot_Machine_Final/source/impl_1/sprite_rom0.mem") ) s3_bram0_inst (.clk(clk), .address(bram_addr), .rgb(s3_bram0_data) );
    rom_block2 #( .text_file("/Users/sanarayanan/my_designs/Slot_Machine_Final/source/impl_1/sprite_rom1.mem") ) s3_bram1_inst (.clk(clk), .address(bram_addr), .rgb(s3_bram1_data) );
    rom_block2 #( .text_file("/Users/sanarayanan/my_designs/Slot_Machine_Final/source/impl_1/sprite_rom2.mem") ) s3_bram2_inst (.clk(clk), .address(bram_addr), .rgb(s3_bram2_data) );
    rom_block2 #( .text_file("/Users/sanarayanan/my_designs/Slot_Machine_Final/source/impl_1/sprite_rom3.mem") ) s3_bram3_inst (.clk(clk), .address(bram_addr), .rgb(s3_bram3_data) );

    // Sprite 4 (4 BRAMs)
    rom_block2 #( .text_file("/Users/sanarayanan/my_designs/Slot_Machine_Final/source/impl_1/sprite_rom0.mem") ) s4_bram0_inst (.clk(clk), .address(bram_addr), .rgb(s4_bram0_data) );
    rom_block2 #( .text_file("/Users/sanarayanan/my_designs/Slot_Machine_Final/source/impl_1/sprite_rom1.mem") ) s4_bram1_inst (.clk(clk), .address(bram_addr), .rgb(s4_bram1_data) );
    rom_block2 #( .text_file("/Users/sanarayanan/my_designs/Slot_Machine_Final/source/impl_1/sprite_rom2.mem") ) s4_bram2_inst (.clk(clk), .address(bram_addr), .rgb(s4_bram2_data) );
    rom_block2 #( .text_file("/Users/sanarayanan/my_designs/Slot_Machine_Final/source/impl_1/sprite_rom3.mem") ) s4_bram3_inst (.clk(clk), .address(bram_addr), .rgb(s4_bram3_data) );

    // Sprite 5 (4 BRAMs)
    rom_block2 #( .text_file("/Users/sanarayanan/my_designs/Slot_Machine_Final/source/impl_1/sprite_rom0.mem") ) s5_bram0_inst (.clk(clk), .address(bram_addr), .rgb(s5_bram0_data) );
    rom_block2 #( .text_file("/Users/sanarayanan/my_designs/Slot_Machine_Final/source/impl_1/sprite_rom1.mem") ) s5_bram1_inst (.clk(clk), .address(bram_addr), .rgb(s5_bram1_data) );
    rom_block2 #( .text_file("/Users/sanarayanan/my_designs/Slot_Machine_Final/source/impl_1/sprite_rom2.mem") ) s5_bram2_inst (.clk(clk), .address(bram_addr), .rgb(s5_bram2_data) );
    rom_block2 #( .text_file("/Users/sanarayanan/my_designs/Slot_Machine_Final/source/impl_1/sprite_rom3.mem") ) s5_bram3_inst (.clk(clk), .address(bram_addr), .rgb(s5_bram3_data) );

    // Sprite 6 (4 BRAMs)
    rom_block2 #( .text_file("/Users/sanarayanan/my_designs/Slot_Machine_Final/source/impl_1/sprite_rom0.mem") ) s6_bram0_inst (.clk(clk), .address(bram_addr), .rgb(s6_bram0_data) );
    rom_block2 #( .text_file("/Users/sanarayanan/my_designs/Slot_Machine_Final/source/impl_1/sprite_rom1.mem") ) s6_bram1_inst (.clk(clk), .address(bram_addr), .rgb(s6_bram1_data) );
    rom_block2 #( .text_file("/Users/sanarayanan/my_designs/Slot_Machine_Final/source/impl_1/sprite_rom2.mem") ) s6_bram2_inst (.clk(clk), .address(bram_addr), .rgb(s6_bram2_data) );
    rom_block2 #( .text_file("/Users/sanarayanan/my_designs/Slot_Machine_Final/source/impl_1/sprite_rom3.mem") ) s6_bram3_inst (.clk(clk), .address(bram_addr), .rgb(s6_bram3_data) );


    // --- Data Selection (Combinational Mux) ---
    logic [15:0] selected_word;
    
    always_comb begin
        unique case (sprite_sel_i)
            3'd0: begin
                unique case (bram_select) 2'd0: selected_word = s0_bram0_data; 2'd1: selected_word = s0_bram1_data; 2'd2: selected_word = s0_bram2_data; 2'd3: selected_word = s0_bram3_data; default: selected_word = 16'h0000; endcase
            end
            3'd1: begin
                unique case (bram_select) 2'd0: selected_word = s1_bram0_data; 2'd1: selected_word = s1_bram1_data; 2'd2: selected_word = s1_bram2_data; 2'd3: selected_word = s1_bram3_data; default: selected_word = 16'h0000; endcase
            end
            3'd2: begin
                unique case (bram_select) 2'd0: selected_word = s2_bram0_data; 2'd1: selected_word = s2_bram1_data; 2'd2: selected_word = s2_bram2_data; 2'd3: selected_word = s2_bram3_data; default: selected_word = 16'h0000; endcase
            end
            3'd3: begin
                unique case (bram_select) 2'd0: selected_word = s3_bram0_data; 2'd1: selected_word = s3_bram1_data; 2'd2: selected_word = s3_bram2_data; 2'd3: selected_word = s3_bram3_data; default: selected_word = 16'h0000; endcase
            end
            3'd4: begin
                unique case (bram_select) 2'd0: selected_word = s4_bram0_data; 2'd1: selected_word = s4_bram1_data; 2'd2: selected_word = s4_bram2_data; 2'd3: selected_word = s4_bram3_data; default: selected_word = 16'h0000; endcase
            end
            3'd5: begin
                unique case (bram_select) 2'd0: selected_word = s5_bram0_data; 2'd1: selected_word = s5_bram1_data; 2'd2: selected_word = s5_bram2_data; 2'd3: selected_word = s5_bram3_data; default: selected_word = 16'h0000; endcase
            end
            3'd6: begin
                unique case (bram_select) 2'd0: selected_word = s6_bram0_data; 2'd1: selected_word = s6_bram1_data; 2'd2: selected_word = s6_bram2_data; 2'd3: selected_word = s6_bram3_data; default: selected_word = 16'h0000; endcase
            end
            default: selected_word = 16'h0000; 
        endcase
    end
    
    // The output is synchronous (1-cycle latency) because it's the registered output of the rom_block via a combinational mux.
	logic [15:0] data_o_reg;
	
	always_ff @(posedge clk) begin
		data_o_reg <= selected_word;
	end
	
    assign data_o = data_o_reg; //16'h2228; 
    
endmodule






/*
module rom_wrapper (
    input  logic clk,
    input  logic reset,
    input  logic [2:0] sprite_idx,       
    input  logic [5:0] x_in_sprite,      
    input  logic [5:0] y_in_sprite,      
    output logic [2:0] pixel_rgb         
);

    localparam SPRITE_WIDTH = 64;
    localparam DATA_WIDTH = 16;
    localparam ADDRESS_WIDTH = 13;
    
    // Cycle 0: Address calculation (combinational)
    logic [11:0] pixel_index;
    logic [9:0] word_offset;
    logic [ADDRESS_WIDTH-1:0] linear_addr;
    logic [1:0] pixel_in_word;

    assign pixel_index = (y_in_sprite * 64) + x_in_sprite;
    assign word_offset = pixel_index[11:2];
    assign pixel_in_word = x_in_sprite[1:0];
    assign linear_addr = (sprite_idx << 10) | word_offset;

    // Cycle 1: ROM IP reads (has internal register)
    logic [DATA_WIDTH-1:0] read_word;
    
    rom_block rom_block (
        .rd_clk_i(clk),
        .rst_i(),
        .rd_en_i(1'b1),
        .rd_clk_en_i(1'b1),
        .rd_addr_i(linear_addr),
        .rd_data_o(read_word)  // Available in Cycle 1
    );
    
    // Cycle 1: Register BOTH data and pixel selector TOGETHER
    // This keeps them synchronized!
    logic [DATA_WIDTH-1:0] read_word_reg;
    logic [1:0] r_pixel_in_word;
    
    always_ff @(posedge clk) begin
        read_word_reg <= read_word;         // Data from ROM IP
        r_pixel_in_word <= pixel_in_word;   // Selector (same cycle as linear_addr was generated)
    end
    
    // Cycle 2: Extract the correct pixel (combinational)
    // Now read_word_reg and r_pixel_in_word are from the SAME original cycle!
    always_comb begin
        case (r_pixel_in_word)
            2'd0: pixel_rgb = read_word_reg[15:13];
            2'd1: pixel_rgb = read_word_reg[11:9];
            2'd2: pixel_rgb = read_word_reg[7:5];
            2'd3: pixel_rgb = read_word_reg[3:1]; 
            default: pixel_rgb = 3'b000; 
        endcase
    end

endmodule

*/

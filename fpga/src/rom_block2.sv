module rom_block2 #(
    parameter string text_file,
    parameter int UNIQUE_ID = 0  // Forces separate synthesis for each instance
) (
    input  logic clk,
    input  logic [7:0] address,
    output logic [15:0] rgb
);
    localparam SPRITE_WIDTH = 64;
    localparam DATA_WIDTH = 16;
    localparam TOTAL_WORDS = 256;
    localparam ADDRESS_WIDTH = 8;
    
    (* syn_ramstyle = "EBR" *)
    (* syn_preserve = 1 *)
    logic [DATA_WIDTH-1:0] single_bram1 [0:TOTAL_WORDS-1];
    
    initial begin 
        $readmemh(text_file, single_bram1);
    end
    
    always_ff @(posedge clk) begin 
        rgb <= single_bram1[address]; 
    end
endmodule


module tb;

    logic        clk = 0       ;
    logic        reset_n       ;
    logic [10:0] hcount,       ;
    logic [9:0]  vcount        ;
    logic        vsync         ;
    logic        active_video  ;
    logic [2:0]  final1_sprite ;
    logic [2:0]  final2_sprite ;
    logic [2:0]  final3_sprite ;
    logic        start_spin    ;
    logic [2:0]  pixel_rgb     ;
    logic        done          ;

    memory_controller DUT (
        .clk           (clk           ),
        .reset_n       (reset_n       ),
        .hcount        (hcount        ), 
        .vcount        (vcount        ),
        .vsync         (vsync         ),
        .active_video  (active_video  ),
        .final1_sprite (final1_sprite ), 
        .final2_sprite (final2_sprite ), 
        .final3_sprite (final3_sprite ),
        .start_spin    (start_spin    ),
        .pixel_rgb     (pixel_rgb     ),
        .done          (done          )
    );

    vga_controller vga (
        .clk          ( clk          ),
        .reset_n      ( reset_n      ),
        .hsync        ( hsync        ),
        .vsync        ( vsync        ),
        .hcount       ( hcount       ),
        .vcount       ( vcount       ),
        .active_video ( active_video )
    );

    `define DV

    // VCD trace logging
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, tb);
    end

    // clock and reset generation
    initial begin
        forever #10 clk = ~clk;
    end

    initial begin
        reset_n = 0; #22 reset_n = 1;
    end

    // TODO: stimulus generation goes here
    


endmodule
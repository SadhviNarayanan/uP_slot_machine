module tb;

    logic        clk           = 0;
    logic        reset_n       = 0;
    logic [10:0] hcount        = 0;
    logic [9:0]  vcount        = 0;
    logic        vsync         = 0;
    logic        hsync         = 0;
    logic        active_video  = 0;
    logic [2:0]  final1_sprite = 0;
    logic [2:0]  final2_sprite = 0;
    logic [2:0]  final3_sprite = 0;
    logic        start_spin    = 0;
    logic [2:0]  pixel_rgb     = 0;
    logic        done          = 0;

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
    `ifndef VERILATOR
        `define VERILATOR
    `endif

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

    always @(negedge vsync) $display("new frame at time %t", $time);

    // stimulus generation
    initial begin

        start_spin = 0;

        #55;
        @(posedge clk);
        start_spin = 1;
        $display("starting first spin at time %t", $time);
        @(posedge clk);
        start_spin = 0;
        wait (done);
        $display("first spin done at time %t", $time);
        
        #111;
        @(posedge clk);
        start_spin = 1;
        @(posedge clk);
        start_spin = 0;
        wait (done);

        #8000;
        @(posedge clk);
        start_spin = 1;
        @(posedge clk);
        start_spin = 0;
        wait (done);
        
    end
    
endmodule

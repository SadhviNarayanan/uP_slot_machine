
module tb;

    logic clk = 0;
    logic reset_n;
    logic hsync;
    logic vsync;
    logic [10:0] hcount;
    logic [9:0]  vcount;
    logic active_video;

    vga_controller DUT (
        .clk          ( clk          ),
        .reset_n      ( reset_n      ),
        .hsync        ( hsync        ),
        .vsync        ( vsync        ),
        .hcount       ( hcount       ),
        .vcount       ( vcount       ),
        .active_video ( active_video )
    );

    `define DV
    `define NUM_FRAMES 100

    // VCD trace logging
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, tb_your_design);
    end

    // clock and reset generation
    initial begin
        forever #10 clk = ~clk;
    end

    initial begin
        reset_n = 0; #22 reset_n = 1;
    end

    // watchdog
    logic [$clog2(`NUM_FRAMES) : 0] dv_vsync_pulse_count = 0;
    always @(posedge clk) begin
        if ($fell(vsync)) begin
            dv_vsync_pulse_count <= dv_vsync_pulse_count + 1;
            // $display("VSYNC FELL, count at %d", dv_vsync_pulse_count);
        end
        if (dv_vsync_pulse_count >= `NUM_FRAMES) $finish;
    end

endmodule
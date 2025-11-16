/*
module memory_controller ( // TODO: need to define bus lengths
    input logic clk, // TODO: this is the 25.175MHz clock
    input logic reset_n,
    input logic [10:0] hcount, 
    input logic [9:0] vcount,
    input logic vsync,
    input logic active_video,
    input logic [2:0] final1_sprite, 
    input logic [2:0] final2_sprite, 
    input logic [2:0] final3_sprite,
    input logic start_spin,
    output logic [2:0] pixel_rgb,
    output logic done
);
*/

// AUXILLIARY (HELPER) CODE
logic [31:0] dv_hsync_low_cycles;
logic [31:0] dv_hsync_high_cycles;
logic [31:0] dv_vsync_low_cycles;
logic [31:0] dv_vsync_high_cycles;

always @(posedge clk) begin
    if (!reset_n) begin

        dv_hsync_low_cycles  <= 0;
        dv_hsync_high_cycles <= 0;
        dv_vsync_low_cycles  <= 0;
        dv_vsync_high_cycles <= 0;

    end else begin

        if (hsync) begin
            dv_hsync_high_cycles <= dv_hsync_high_cycles + 1;
            dv_hsync_low_cycles  <= 0;
        end else begin
            dv_hsync_low_cycles  <= dv_hsync_low_cycles + 1;
            dv_hsync_high_cycles <= 0;
        end

        if (vsync) begin
            dv_vsync_high_cycles <= dv_vsync_high_cycles + 1;
            dv_vsync_low_cycles  <= 0;
        end else begin
            dv_vsync_low_cycles  <= dv_vsync_low_cycles + 1;
            dv_vsync_high_cycles <= 0;
        end

    end
end

// UNCONSTRAINED INPUTS
`ifndef VERILATOR
    rand reg       rand_start_spin;
    rand reg [2:0] rand_final1_sprite;
    rand reg [2:0] rand_final2_sprite;
    rand reg [2:0] rand_final3_sprite;

    always @* assume (rand_start_spin    == start_spin   );
    always @* assume (rand_final1_sprite == final1_sprite);
    always @* assume (rand_final2_sprite == final2_sprite);
    always @* assume (rand_final3_sprite == final3_sprite);
`endif

// ASSUME PROPERTIES
/*

`ifndef VERILATOR
    always @* assume (!reset_n == $initstate);
`endif

always @* assume (eventually(start_spin));

always @(posedge clk) begin

    assume (hcount < H_TOTAL);
    assume (vcount < V_TOTAL);

end

always @(posedge clk) begin if (reset_n) begin

    if ($past(reset_n))                                                    // only valid if reset was not asserted on the last cycle
        if (hsync && $past(!hsync))                                        // if hsync transitions low to high...
            assume (dv_hsync_low_cycles == H_SYNC);                        // then the count of low cycles is the number of hsync cycles

    if ($past(reset_n))                                                    // only valid if reset was not asserted on the last cycle
        if (vsync && $past(!vsync))                                        // if vsync transitions low to high...
            assume (dv_vsync_low_cycles == V_SYNC * H_TOTAL);              // then the count of low cycles is the number of vsync cycles

    if ($past(reset_n))                                                    // only valid if reset was not asserted on the last cycle
        if (!hsync && $past(hsync))                                        // if hsync transitions high to low...
            assume (dv_hsync_high_cycles == H_TOTAL - H_SYNC);             // then the count of high cycles is the number of !hsync cycles

    if ($past(reset_n))                                                    // only valid if reset was not asserted on the last cycle
        if (!vsync && $past(vsync))                                        // if vsync transitions high to low...
            assume (dv_vsync_high_cycles == (V_TOTAL - V_SYNC) * H_TOTAL); // then the count of high cycles is the number of !vsync cycles

end end

always @(posedge clk) begin if (reset_n) begin

    // counts either increment or roll back to 0 from max value
    if ($past(reset_n)) // only valid if reset was not asserted on the last cycle
        assume ((hcount == $past(hcount) + 1) || (hcount == 0 && $past(hcount) == H_TOTAL - 1));

    if ($fell(hsync))
        assume ((vcount == $past(vcount) + 1) || (vcount == 0 && $past(vcount) == V_TOTAL - 1)); 

end end

always @(posedge clk) begin if (reset_n) begin

    if (!hsync || !vsync) assert (!active_video);

end end
*/
rand reg rand_clk;
rand reg rand_reset_n;
rand reg rand_hsync;
rand reg rand_vsync;
rand reg rand_hcount;
rand reg rand_vcount;
rand reg rand_active_video;

vga_controller vga (
        .clk          ( rand_clk          ),
        .reset_n      ( rand_reset_n      ),
        .hsync        ( rand_hsync        ),
        .vsync        ( rand_vsync        ),
        .hcount       ( rand_hcount       ),
        .vcount       ( rand_vcount       ),
        .active_video ( rand_active_video )
    );

always @* assume (rand_clk          == clk          );
always @* assume (rand_reset_n      == reset_n      );
always @* assume (rand_hsync        == hsync        );
always @* assume (rand_vsync        == vsync        );
always @* assume (rand_hcount       == hcount       );
always @* assume (rand_vcount       == vcount       );
always @* assume (rand_active_video == active_video );


// SAFETY PROPERTIES
always @* assert (sprite_idx <= 6);

always @(posedge clk) begin if (reset_n && $past(reset_n)) begin

    if ($changed(state)) begin

        case ($past(state)) 
            IDLE:           assert (state == START_SPINNING);
            START_SPINNING: assert (state == REEL1_STOP    );
            REEL1_STOP:     assert (state == REEL2_STOP    );
            REEL2_STOP:     assert (state == REEL3_STOP    );
            REEL3_STOP:     assert (state == IDLE          );
            default:        assert (1);
        endcase

    end

end end 


// LIVENESS PROPERTIES
always @(posedge clk) begin if (reset_n) begin

    if ($rose(start_spin))
        assert (eventually(done));

    if (state == IDLE)
        assert (eventually(state == START_SPINNING));

    if (state == START_SPINNING)
        assert (eventually(state == REEL1_STOP));

    if (state == REEL1_STOP)
        assert (eventually(state == REEL2_STOP));

    if (state == REEL2_STOP)
        assert (eventually(state == REEL3_STOP));

    if (state == REEL3_STOP)
        assert (eventually(state == IDLE));

end end
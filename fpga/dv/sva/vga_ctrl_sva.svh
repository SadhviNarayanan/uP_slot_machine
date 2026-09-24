
/*
module vga_controller (input  logic clk, 
                       input  logic reset_n, 
                       output logic hsync, 
                       output logic vsync, 
                       output logic [10:0] hcount,  // 0–799
                       output logic [9:0]  vcount,   // 0–524
                       output logic active_video);

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

// ASSUME PROPERTIES
`ifndef VERILATOR
    always @* assume (!reset_n == $initstate);
`endif


// COVER PROPERTIES
always @(posedge clk) begin if (reset_n) begin

    cover (hcount == 0 && $past(hcount) == H_TOTAL - 1); // hcount wrap around
    cover (vcount == 0 && $past(vcount) == V_TOTAL - 1); // vcount wrap around
    cover (hsync == 1);
    cover (vsync == 1);
    cover (hsync == 0);
    cover (vsync == 0);
    cover (active_video == 1);
    cover (active_video == 0);

    // int i; 
    // for (i = 0; i < H_TOTAL; i=i+1) begin : gen_hcount_covers

    //     cover(hcount == i);

    // end // gen_hcount_covers

    // for (i = 0; i < V_TOTAL; i=i+1) begin : gen_vcount_covers

    //     cover(vcount == i);

    // end // gen_vcount_covers

end end // COVER PROPERTIES


// HCOUNT & VCOUNT SAFETY PROPERTIES
always @(posedge clk) begin if (reset_n) begin

    // counts in valid range
    assert (hcount < H_TOTAL);
    assert (vcount < V_TOTAL);

    // counts either increment or roll back to 0 from max value
    if ($past(reset_n)) // only valid if reset was not asserted on the last cycle
        assert ((hcount == $past(hcount) + 1) || (hcount == 0 && $past(hcount) == H_TOTAL - 1));

    if ($fell(hsync))
        assert ((vcount == $past(vcount) + 1) || (vcount == 0 && $past(vcount) == V_TOTAL - 1));

    // assert (0);
    

end end // HCOUNT & VCOUNT SAFETY PROPERTIES



// HSYNC & VSYNC SAFETY PROPERTIES
always @(posedge clk) begin if (reset_n) begin

    if ($past(reset_n))                                                    // only valid if reset was not asserted on the last cycle
        if (hsync && $past(!hsync))                                        // if hsync transitions low to high...
            assert (dv_hsync_low_cycles == H_SYNC);                        // then the count of low cycles is the number of hsync cycles

    if ($past(reset_n))                                                    // only valid if reset was not asserted on the last cycle
        if (vsync && $past(!vsync))                                        // if vsync transitions low to high...
            assert (dv_vsync_low_cycles == V_SYNC * H_TOTAL);              // then the count of low cycles is the number of vsync cycles

    if ($past(reset_n))                                                    // only valid if reset was not asserted on the last cycle
        if (!hsync && $past(hsync))                                        // if hsync transitions high to low...
            assert (dv_hsync_high_cycles == H_TOTAL - H_SYNC);             // then the count of high cycles is the number of !hsync cycles

    if ($past(reset_n))                                                    // only valid if reset was not asserted on the last cycle
        if (!vsync && $past(vsync))                                        // if vsync transitions high to low...
            assert (dv_vsync_high_cycles == (V_TOTAL - V_SYNC) * H_TOTAL); // then the count of high cycles is the number of !vsync cycles
    

end end // HSYNC & VSYNC SAFETY PROPERTIES


// active_video SAFETY PROPERTIES
always @(posedge clk) begin if (reset_n) begin

    if (!hsync || !vsync) assert (!active_video);

end end // active_video SAFETY PROPERTIES

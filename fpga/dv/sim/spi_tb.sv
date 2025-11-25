// `define SPI_TCLK_H 5ns
// `define SPI_TCLK_L 20ns

module tb();
    
    
    // VCD trace logging
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, tb);
    end
    
    // (* keep *) logic mosi;
    // (* keep *) logic sck  = 0;
    // (* keep *) logic cs   = 1;
    // (* keep *) logic rstn = 1;

    (* keep *) logic sck = 0;
    (* keep *) logic rstn = 0;
    (* keep *) logic mosi;
    (* keep *) logic cs = 1;
    (* keep *) logic miso;
    (* keep *) logic [3:0] reel1_idx;
    (* keep *) logic [3:0] reel2_idx;
    (* keep *) logic [3:0] reel3_idx;
    (* keep *) logic start_spin;
    (* keep *) logic [11:0] win_credits;
    (* keep *) logic is_win;
    (* keep *) logic [11:0] total_credits;
    (* keep *) logic is_total;

    initial begin

        rstn = 0;
        #50ns;
        rstn = 1;
        #50ns;

        spi_send16(16'h136F, mosi, sck, cs);
        #100ns;
        spi_send16(16'h20AA, mosi, sck, cs);
        #50ns;

    end

    spi_data_extract DUT (.sclk(sck), 
                          .reset_n(rstn), 
                          .copi(mosi), // sdi 
                          .cs(cs),  // active low
                          .sdo(miso),
                          .reel1_idx(reel1_idx), // make sure in register
                          .reel2_idx(reel2_idx), 
                          .reel3_idx(reel3_idx), 
                          .start_spin(start_spin), 
                          .win_credits(win_credits), 
                          .is_win(is_win), 
                          .total_credits(total_credits), 
                          .is_total(is_total)
); 


endmodule

task automatic spi_send16 (
    input  logic [15:0] data,
    ref    logic mosi, sck, cs
);

    cs = 0;
    sck = 0;
    #30ns;

    for (int i = 15; i >= 0; i = i - 1) begin
        mosi = data[i];
        #10ns;
        sck = 1;
        #5ns; 
        sck = 0;
        #10ns;
    end

    #30ns;
    cs = 1;

endtask

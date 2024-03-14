module gray_bench;
  localparam WIDTH = 32;
  logic [WIDTH-1:0] i_bin;
  logic [WIDTH-1:0] o_gray;
  logic [WIDTH-1:0] o_bin;
  logic [WIDTH-1:0] g_bin;

  always_comb begin
    g_bin = '0;
    for (int i = 0; i < WIDTH; ++i) begin
      g_bin ^= o_gray >> i;
    end
  end

  std_bin2gray #(WIDTH) dut2(.i_bin, .o_gray);
  std_gray2bin #(WIDTH) dut1(.i_gray(o_gray), .o_bin);

  initial begin
    for (longint i = 0; i < (1 << WIDTH); ++i) begin
      i_bin = i;
      #1;
      assert(o_bin == g_bin);
      assert(i_bin == o_bin);
      #1;
    end
  end

endmodule

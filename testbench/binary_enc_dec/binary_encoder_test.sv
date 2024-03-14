module binary_encoder_test;

  parameter BIN_WIDTH = 8;
  parameter UNARY_WIDTH = 1 << BIN_WIDTH;

  logic i_en;
  logic [BIN_WIDTH-1:0] o_bin;
  logic [UNARY_WIDTH-1:0] i_unary;

  std_binary_encoder #(UNARY_WIDTH) (.*);

  initial begin
    i_en = 1'b1;

    for (longint i = 0; i < UNARY_WIDTH; ++i) begin
      #1 i_unary = 1 << i;
      #1 assert(i_unary[o_bin] == 1'b1);
    end

  end

endmodule


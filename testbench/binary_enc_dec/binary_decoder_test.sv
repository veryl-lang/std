module binary_decoder_test;

  parameter BIN_WIDTH = 8;
  parameter UNARY_WIDTH = 1 << BIN_WIDTH;

  logic i_en;
  logic [BIN_WIDTH-1:0] i_bin;
  logic [UNARY_WIDTH-1:0] o_unary;

  std_binary_decoder #(BIN_WIDTH) (.*);

  initial begin
    i_en = 1'b1;

    for (longint i = 0; i < UNARY_WIDTH; ++i) begin
      i_bin = i;
      #1 assert($onehot(o_unary));
      assert(o_unary[i_bin] == 1'b1);
    end

  end

endmodule


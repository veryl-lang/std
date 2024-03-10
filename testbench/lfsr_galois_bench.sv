module testbench;
    parameter MAXSIZE = 24;
    parameter MINSIZE = 2;

    logic [MAXSIZE-1:MINSIZE] done;
    logic [MAXSIZE-1:MINSIZE] working;
    logic i_clk;

    for (genvar i = MINSIZE; i < MAXSIZE; ++i) begin
        initial $display ("Spawning LFSR of Size %d", i);
        lfsr_galois_bench #(.SIZE(i)) u_lfsr(.i_clk, .done(done[i]), .working(working[i]));
    end
    default clocking
      @(posedge i_clk);
    endclocking

    initial forever begin
        ##4
        if (&done) begin
            if (|working) begin
                $display("Finishing Simulations with \033[32m100%% Success\033[0m");
            end else begin
                $display("Finishing Simulations with \033[31mErrors\033[0m");
            end
            $finish;
        end
    end

  initial begin
    i_clk = 1'b0;
    forever #5 i_clk = ~i_clk;
  end
endmodule

module lfsr_galois_bench #(parameter SIZE=64) (input i_clk, output logic done, output logic working);
  logic [SIZE:0] limit;


  logic i_en, i_set;
  logic [SIZE-1:0] i_setval;
  logic [SIZE-1:0] o_val;

  stochastic_computing_lfsr_galois #(.SIZE(SIZE)) dut (.*);


  default clocking
    @(posedge i_clk);
  endclocking


  initial begin
    int outvecs [logic[SIZE-1:0]];
    working = 1'b1;
    $display("Begining LFSR of Size %d", SIZE);
    done = 1'b0;
    i_en = 1'b1;
    i_set = 1'b1;
    i_setval = 16'h0001;

    ##2;

    i_set = 1'b0;
    limit = '1;
    limit[0] = 1'b0; 
    limit[SIZE] = 1'b0;

    for (int i = 0; i < limit; i += 1) begin
      ##1;
      assert(0 == outvecs.exists(o_val));
      working &= !outvecs.exists(o_val);
      outvecs[o_val] = 1'b1;
    end

    done = 1'b1;

    if (working) 
        $display("Succesfully Ending LFSR of Size %0d", SIZE);
    else
        $display("Failure Detecing in LFSR of size %0d", SIZE);

  end

endmodule

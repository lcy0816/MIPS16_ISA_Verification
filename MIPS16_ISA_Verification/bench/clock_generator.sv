`timescale 1ns/1ps
module clock_generator(
    output  logic   clock
);
    localparam CLK_PERIOD       = 10;
    logic                   clk = 0;

    always #(CLK_PERIOD /2) 
        clk =~clk;

    assign clock = clk;  

endmodule
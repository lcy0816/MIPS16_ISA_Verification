`timescale 1ns/1ps
`include "mips_16_defs.v"

module mem_top();

    //Local variables
    logic           clk;
    logic           rst;
    logic  [37:0]   pipeline_reg_in;
    logic  [36:0]   pipeline_reg_out;
    logic  [2:0]    mem_op_dest;    

    //Instances
    clock_generator u_clock_generator( .clock (clk) );
    MEM_stage uut ( .*);
    mem_top_tb u_mem_top_tb( 
                                .reset                  ( rst                   ),
                                .o_pipeline_reg_in     ( pipeline_reg_in  ),
                                .i_pipeline_reg_out    ( pipeline_reg_out    ),
                                .i_mem_op_dest          ( mem_op_dest                    ),
                                .clock                  ( clk                   )
                                );
    bind uut.dmem mem_assertions u_assertions( .rst(mem_top.rst), .* );    




endmodule
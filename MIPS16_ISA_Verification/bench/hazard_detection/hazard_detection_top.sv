`timescale 1ns/1ps
`include "mips_16_defs.v"

module hazard_detection_top();

    //Local variables
    logic           clk;
    logic           rst;
    logic  [2:0]    decoding_op_src1;
    logic  [2:0]    decoding_op_src2;
    logic  [2:0]    ex_op_dest;
    logic  [2:0]    mem_op_dest;
    logic  [2:0]    wb_op_dest;
    logic           pipeline_stall_n;
    
    

    //Instances
    clock_generator u_clock_generator( .clock (clk) );
    hazard_detection_unit uut ( .*);
    hazard_detection_top_tb u_hazard_detection_top_tb( 
                                .reset                  ( rst               ),
                                .o_decoding_op_src1     ( decoding_op_src1  ),
                                .o_decoding_op_src2     ( decoding_op_src2  ),
                                .o_ex_op_dest           ( ex_op_dest        ),
                                .o_mem_op_dest          ( mem_op_dest       ),
                                .o_wb_op_dest           ( wb_op_dest        ),
                                .i_pipeline_stall_n     ( pipeline_stall_n  ),
                                .clock                  ( clk               )
                                );
    bind hazard_detection_unit hazard_detection_assertions u_assertions( .clk(hazard_detection_top.clk ), .rst(hazard_detection_top.rst), .* );    




endmodule
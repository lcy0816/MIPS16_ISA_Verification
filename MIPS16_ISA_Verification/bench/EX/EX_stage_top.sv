`timescale 1ns/1ps
`include "mips_16_defs.v"

module EX_stage_top();

    //Local variables
    logic           clk;
    logic           rst;

    logic  [56:0]      pipeline_reg_in;   
    logic  [37:0]      pipeline_reg_out;
    logic  [ 2:0]      ex_op_dest;
    
    

    //Instances
    clock_generator u_clock_generator( .clock (clk) );
    EX_stage uut ( .*);
    Ex_stage_top_tb u_ex_stage_top_tb( 
                                .reset                  ( rst               ),
                                .reg_pipeline_in        ( pipeline_reg_in   ),
                                .reg_pipeline_out       ( pipeline_reg_out  ),
                                .op_ex_dest             ( ex_op_dest        ),
                                .clock                  ( clk               )
                                );
    bind uut EX_assertions u_assertions( .* );    

endmodule
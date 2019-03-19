`timescale 1ns/1ps
`include "mips_16_defs.v"

module wb_top();

    //Local variables
 
    logic               clk;
    logic               rst;
    logic               reg_write_en;
    logic   [2:0]       reg_write_dest;
    logic   [15:0]      reg_write_data;
    
    logic   [2:0]       wb_op_dest;
   
    logic   [36:0]      pipeline_reg_in;     

    //Instances
    clock_generator u_clock_generator( .clock (clk) );
    WB_stage uut ( .*);
    wb_top_tb u_wb_top_tb(
                                .clock              ( clk               ),
                                .reset              ( rst               ), 
                                .i_reg_write_en     ( reg_write_en      ),
                                .i_reg_write_dest   ( reg_write_dest    ),
                                .i_reg_write_data   ( reg_write_data    ),
                                .i_wb_op_dest       ( wb_op_dest        ),
                                .o_pipeline_reg_in  ( pipeline_reg_in   )
                                );
    bind uut wb_assertions u_assertions( .clk( wb_top.clk), .rst( wb_top.rst), .* );    




endmodule
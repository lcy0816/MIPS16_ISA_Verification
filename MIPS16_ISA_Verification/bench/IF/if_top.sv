`timescale 1ns/1ps
`include "mips_16_defs.v"

module if_top();

    //Local variables
    logic           clk;
    logic           rst;
    logic           instruction_fetch_en;
    logic  [5:0]    branch_offset_imm;
    logic           branch_taken;
    logic  [`PC_WIDTH-1:0]    pc;
    logic  [15:0]    instruction;    

    //Instances
    clock_generator u_clock_generator( .clock (clk) );
    IF_stage uut ( .*);
    if_top_tb u_if_top_tb( 
                                .reset                  ( rst                   ),
                                .o_instruction_fetch_en ( instruction_fetch_en  ),
                                .o_branch_offset_imm    ( branch_offset_imm     ),
                                .o_branch_taken         ( branch_taken          ),
                                .i_pc                   ( pc                    ),
                                .i_instruction          ( instruction           ),
                                .clock                  ( clk                   )
                                );
    bind uut if_assertions u_assertions( .* );    




endmodule
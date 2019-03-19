`timescale 1ns/1ps
`include "mips_16_defs.v"

module id_top();

    //Local variables
    logic           clk;
    logic           rst;
    logic           instruction_decode_en;
    logic  [56:0]   pipeline_reg_out;   //  [56:22],35bits: ex_alu_cmd[2:0], ex_alu_src1[15:0], ex_alu_src2[15:0]
                                        //  [21:5],17bits:  mem_write_en, mem_write_data[15:0]
                                        //  [4:0],5bits:    write_back_en, write_back_dest[2:0], write_back_result_mux, 
    
    // to IF_stage
    logic  [15:0]   instruction;
    logic  [5:0]    branch_offset_imm;
    logic           branch_taken;
    
    // to register file
    logic   [2:0]   reg_read_addr_1;    // register file read port 1 address
    logic   [2:0]   reg_read_addr_2;    // register file read port 2 address
    logic   [15:0]  reg_read_data_1;    // register file read port 1 data
    logic   [15:0]  reg_read_data_2;    // register file read port 2 data
    
    // to hazard detection unit
    logic  [2:0]    decoding_op_src1;   //source_1 register number
    logic  [2:0]    decoding_op_src2;   //source_2 register number   

    //Instances
    clock_generator u_clock_generator( .clock (clk) );
    ID_stage uut ( .*);
    id_top_tb u_id_top_tb( 
                                .reset                  ( rst                   ),
                                .o_instruction_decode_en( instruction_decode_en  ),
                                .i_branch_offset_imm    ( branch_offset_imm     ),
                                .i_pipeline_reg_out     ( pipeline_reg_out      ),
                                .i_branch_taken         ( branch_taken          ),
                                .o_instruction          ( instruction           ),
                                .i_reg_read_addr_1      ( reg_read_addr_1       ),
                                .i_reg_read_addr_2      ( reg_read_addr_2       ),
                                .o_reg_read_data_1      ( reg_read_data_1       ),
                                .o_reg_read_data_2      ( reg_read_data_2       ),
                                .i_decoding_op_src1     ( decoding_op_src1      ),    
                                .i_decoding_op_src2     ( decoding_op_src2      ),
                                .clock                  ( clk                   )
                                );
    bind uut id_assertions u_assertions( .* );    




endmodule
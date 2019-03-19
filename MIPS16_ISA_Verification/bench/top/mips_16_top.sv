`timescale 1ns/1ps
`include "mips_16_defs.v"

module mips_16_top();

    //Local variables
    logic clk;
    logic rst;
    wire [`PC_WIDTH-1:0]    pc;
    string current_test;


    //Instances
    clock_generator u_clock_generator( .clock (clk) );
    mips_16_core_top uut ( .*);
    mips_16_top_tb u_mips_16_top_tb( .reset(rst), .current_test( current_test) );
    reg_saver u_reg_saver(.*);

    bind uut.hazard_detection_unit_inst hazard_detection_assertions u_hazard_detection_assertions( .clk(mips_16_top.clk ), .rst(mips_16_top.rst), .* );    
    bind uut.register_file_inst register_file_assertions u_rf_assertions( .* );    
    bind uut.MEM_stage_inst.dmem mem_assertions u_mem_assertions( .rst(mips_16_top.rst), .* );    
    bind uut.WB_stage_inst wb_assertions u_wb_assertions( .clk(mips_16_top.clk ), .rst(mips_16_top.rst), .* );    
    bind uut.IF_stage_inst if_assertions u_if_assertions( .* );    
    bind uut.EX_stage_inst EX_assertions u_ex_assertions( .* );    
    bind uut.ID_stage_inst id_assertions u_id_assertions( .* );    

endmodule
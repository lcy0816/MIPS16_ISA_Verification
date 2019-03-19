////////////////////////////////////////////////////////////////////////////////
// Engineer: Ignacio Genovese
//
// Create Date:   02/27/2012
// Design Name:   mips_16_top_tb
// Project Name:  mips_16
// Target Device:  
// Tool versions:  
// Description: 
// Testbench for mips16_top. This module takes the output of the assembly 
// compiler and stimulates the mips16 top.
////////////////////////////////////////////////////////////////////////////////
`timescale 1ns/1ps
`include "mips_16_defs.v"

program mips_16_top_tb(
    output  reset,
    output  string current_test
);

    localparam CLK_PERIOD   = 10;
    localparam N_TESTS      = 29;

    logic                   rst = 0;
    logic   [15:0]          reg_file_res[7:0];
    logic   [ 7:0]          mem_res[255:0];
    integer                 reg_file;
    integer                 mem_file;
    integer                 reg_line;
    integer                 mem_line;
    int                     test_errors  = 0;
    int                     total_errors = 0;
    int                     cycles = 0;
    string                  test_name[N_TESTS] = '{ 
                                                    "hazard_detection",
                                                    "hazard_r0",
                                                    "hazard_r1",
                                                    "hazard_r2",
                                                    "hazard_r3",
                                                    "hazard_r4",
                                                    "hazard_r5",
                                                    "hazard_r6",
                                                    "hazard_r7",                                                    
                                                    "add",
                                                    "sub",
                                                    "and",
                                                    "or",
                                                    "xor",
                                                    "sl",
                                                    "sr",
                                                    "sru",
                                                    "addi",
                                                    "branch_taken",                                                    
                                                    "branch_not_taken",
                                                    "nop",    
                                                    "R0_load",
                                                    "R1_load_store",
                                                    "R2_load_store",
                                                    "R3_load_store",
                                                    "R4_load_store",
                                                    "R5_load_store",
                                                    "R6_load_store",
                                                    "R7_load_store"                                                                                                   
                                                  };

    string                  clear_mem          =    "../../bench/top/testcases/clear_mem";
    string                  testcases[N_TESTS] = '{ 
                                                    "../../bench/top/testcases/hazard_detection.prog",
                                                    "../../bench/top/testcases/hazard_r0.prog",
                                                    "../../bench/top/testcases/hazard_r1.prog",
                                                    "../../bench/top/testcases/hazard_r2.prog",
                                                    "../../bench/top/testcases/hazard_r3.prog",
                                                    "../../bench/top/testcases/hazard_r4.prog",
                                                    "../../bench/top/testcases/hazard_r5.prog",
                                                    "../../bench/top/testcases/hazard_r6.prog",
                                                    "../../bench/top/testcases/hazard_r7.prog",                                                                                                        
                                                    "../../bench/top/testcases/add.prog",
                                                    "../../bench/top/testcases/sub.prog",
                                                    "../../bench/top/testcases/and.prog",
                                                    "../../bench/top/testcases/or.prog",
                                                    "../../bench/top/testcases/xor.prog",
                                                    "../../bench/top/testcases/sl.prog",
                                                    "../../bench/top/testcases/sr.prog",
                                                    "../../bench/top/testcases/sru.prog",
                                                    "../../bench/top/testcases/addi.prog", 
                                                    "../../bench/top/testcases/branch_taken.prog",                                               
                                                    "../../bench/top/testcases/branch_not_taken.prog",                                               
                                                    "../../bench/top/testcases/nop.prog",  
                                                    "../../bench/top/testcases/R0_load.prog",
                                                    "../../bench/top/testcases/R1_load_store.prog",
                                                    "../../bench/top/testcases/R2_load_store.prog",
                                                    "../../bench/top/testcases/R3_load_store.prog",
                                                    "../../bench/top/testcases/R4_load_store.prog",
                                                    "../../bench/top/testcases/R5_load_store.prog",
                                                    "../../bench/top/testcases/R6_load_store.prog",
                                                    "../../bench/top/testcases/R7_load_store.prog"
                                                };
    string                  regfile_results[N_TESTS] = '{ 
                                                    "../../bench/top/testcases/hazard_detection_regs",
                                                    "../../bench/top/testcases/hazard_r0_regs",
                                                    "../../bench/top/testcases/hazard_r1_regs",
                                                    "../../bench/top/testcases/hazard_r2_regs",
                                                    "../../bench/top/testcases/hazard_r3_regs",
                                                    "../../bench/top/testcases/hazard_r4_regs",
                                                    "../../bench/top/testcases/hazard_r5_regs",
                                                    "../../bench/top/testcases/hazard_r6_regs",
                                                    "../../bench/top/testcases/hazard_r7_regs",                                                                                                        
                                                    "../../bench/top/testcases/add_reg",
                                                    "../../bench/top/testcases/sub_reg",
                                                    "../../bench/top/testcases/and_reg",
                                                    "../../bench/top/testcases/or_reg",
                                                    "../../bench/top/testcases/xor_reg",
                                                    "../../bench/top/testcases/sl_reg",
                                                    "../../bench/top/testcases/sr_reg",
                                                    "../../bench/top/testcases/sru_reg",
                                                    "../../bench/top/testcases/addi_reg",                                                    
                                                    "../../bench/top/testcases/branch_taken_reg",                                                    
                                                    "../../bench/top/testcases/branch_not_taken_reg",                                                    
                                                    "../../bench/top/testcases/nop_reg",
                                                    "../../bench/top/testcases/R0_load_reg" ,
                                                    "../../bench/top/testcases/R1_load_store_reg",
                                                    "../../bench/top/testcases/R2_load_store_reg",
                                                    "../../bench/top/testcases/R3_load_store_reg",
                                                    "../../bench/top/testcases/R4_load_store_reg",
                                                    "../../bench/top/testcases/R5_load_store_reg",
                                                    "../../bench/top/testcases/R6_load_store_reg",
                                                    "../../bench/top/testcases/R7_load_store_reg"                                                    
                                                };
    string                  mem_results[N_TESTS] = '{ 
                                                    "../../bench/top/testcases/hazard_r0_mem", //equal for all hazard tests
                                                    "../../bench/top/testcases/hazard_r0_mem", 
                                                    "../../bench/top/testcases/hazard_r0_mem",
                                                    "../../bench/top/testcases/hazard_r0_mem",
                                                    "../../bench/top/testcases/hazard_r0_mem",
                                                    "../../bench/top/testcases/hazard_r0_mem",
                                                    "../../bench/top/testcases/hazard_r0_mem",
                                                    "../../bench/top/testcases/hazard_r0_mem",
                                                    "../../bench/top/testcases/hazard_r0_mem",                                                                                                    
                                                    "../../bench/top/testcases/add_mem",
                                                    "../../bench/top/testcases/sub_mem",
                                                    "../../bench/top/testcases/and_mem",
                                                    "../../bench/top/testcases/or_mem",
                                                    "../../bench/top/testcases/xor_mem",
                                                    "../../bench/top/testcases/sl_mem",
                                                    "../../bench/top/testcases/sr_mem",
                                                    "../../bench/top/testcases/sru_mem",
                                                    "../../bench/top/testcases/addi_mem",
                                                    "../../bench/top/testcases/branch_taken_mem",                                                
                                                    "../../bench/top/testcases/branch_not_taken_mem",                                                
                                                    "../../bench/top/testcases/nop_mem",
                                                    "../../bench/top/testcases/R0_load_mem" ,
                                                    "../../bench/top/testcases/R1_load_store_mem",
                                                    "../../bench/top/testcases/R2_load_store_mem",
                                                    "../../bench/top/testcases/R3_load_store_mem",
                                                    "../../bench/top/testcases/R4_load_store_mem",
                                                    "../../bench/top/testcases/R5_load_store_mem",
                                                    "../../bench/top/testcases/R6_load_store_mem",
                                                    "../../bench/top/testcases/R7_load_store_mem"                                               
                                                };


    initial
    begin
        for( int i = 0; i < N_TESTS; i++ )
        begin
            cycles = (i < 21) ? 200 : (i < 22) ? 3100 :  3350; //mem 0 test needs 3100 cycles, other mem tests need 3350 cycles
            current_test = test_name[i];
            sys_reset;
            test_errors = 0;
            $readmemb(clear_mem,mips_16_top.uut.IF_stage_inst.imem.rom);
            $readmemb(testcases[i],mips_16_top.uut.IF_stage_inst.imem.rom);
            $display("#######################################################################################");
            $display("################### RUNNING TEST %s ---- %d cycles ##################", current_test, cycles );            
            reg_file = $fopen(regfile_results[i],"r");
            mem_file = $fopen(mem_results[i],"r");
            if( reg_file == 0 ) 
            begin
                $error("UNABLE TO OPEN REGISTER FILE RESULTS FILE %s \n", regfile_results[i] );
                total_errors++;
                break;
            end
            if( mem_file == 0 ) 
            begin
                $error("UNABLE TO OPEN MEMORY RESULTS FILE %s \n", mem_results[i] );
                total_errors++;
                break;
            end
            for( int j = 0; j < 8; j++ ) $fscanf(reg_file, "%d\n", reg_file_res[j]);
            for( int j = 0; j < 256; j++ ) $fscanf(mem_file, "%d\n", mem_res[j]);
            #(CLK_PERIOD*cycles)
            for( int j = 0; j < 8; j++ ) 
                if( reg_file_res[j] != mips_16_top.uut.register_file_inst.reg_array[j] )
                begin
                    $error("ERROR IN REGISTER FILE COMPARISON - REGISTER %d TEST %s", j, testcases[i]);
                    $display("EXPECTED RESULT = %d, OBTAINED VALUE = %d",reg_file_res[j],  mips_16_top.uut.register_file_inst.reg_array[j] );
                    test_errors++;
                end
            for( int j = 0; j < 256; j++ ) 
                if( mem_res[j] != mips_16_top.uut.MEM_stage_inst.dmem.ram[j] )
                begin
                    $error("ERROR IN MEMORY COMPARISON - MEMORY POSITION %d TEST %s", j, testcases[i]);
                    $display("EXPECTED RESULT = %d, OBTAINED VALUE = %d",mem_res[j], mips_16_top.uut.MEM_stage_inst.dmem.ram[j] );
                    test_errors++;
                end

            if( test_errors == 0 )            
                $display("*************** TEST %s PASS\n", testcases[i]);                            
            else            
                $error("*************** TEST %s FAILED\n", testcases[i]);                
            total_errors += test_errors;
        end
        if( total_errors == 0 )
            $display("********** SIMULATION PASSED - NO ERRORS FOUND! ***********");
        else
            $error("********** SIMULATION FAILED - ERRORS FOUND! ***********");
        $stop();
    end

    assign reset = rst;

    task sys_reset;
        begin
            rst = 1;
            #(CLK_PERIOD*2) rst = 0;            
        end
    endtask

endprogram

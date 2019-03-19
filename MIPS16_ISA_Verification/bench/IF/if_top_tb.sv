`timescale 1ns/1ps
`include "mips_16_defs.v"

program if_top_tb(
    output                  reset,
    output                  o_instruction_fetch_en,
    output  [5:0]           o_branch_offset_imm,
    output                  o_branch_taken,
    input  [`PC_WIDTH-1:0]  i_pc,
    input  [15:0]           i_instruction, 
    input                   clock
);
    localparam              N_TESTS = 16;
    localparam              CLK_PERIOD   = 10;
    string                  test_name[N_TESTS] = '{ 
                                                    "nop",
                                                    "addi",
                                                    "branch_taken",
                                                    "branch_not_taken",
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
                                                    "R0_load",
                                                    "R1_load_store"                                                   
                                                };
string                  clear_mem          =    "../../bench/top/testcases/clear_mem";
string                  testcases[N_TESTS] = '{ 
                                                    "../../bench/top/testcases/nop.prog",  
                                                    "../../bench/top/testcases/addi.prog", 
                                                    "../../bench/top/testcases/branch_taken.prog",                                               
                                                    "../../bench/top/testcases/branch_not_taken.prog",                                                                                               
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
                                                    "../../bench/top/testcases/R0_load.prog",
                                                    "../../bench/top/testcases/R1_load_store.prog"                                                    
                                                };


    string                  current_test;
    logic                   rst;
    integer                 if_instruction_fetch_en;
    integer                 if_branch_offset_imm;
    integer                 if_branch_taken;
 
    integer                 if_pc;  
    integer                 if_instruction;  

    int                     current_test_errors = 0;
    int                     total_errors;      

    logic                   temp_instruction_fetch_en;
    logic  [5:0]            temp_branch_offset_imm;
    logic                   temp_branch_taken;
    logic  [`PC_WIDTH-1:0]  temp_pc;
    logic  [15:0]           temp_instruction;
    initial 
    begin
        for(int i = 0; i < N_TESTS; i++ )
        begin
            current_test            = test_name[i];
            current_test_errors     = 0;
            sys_reset;
            $readmemb(clear_mem,uut.imem.rom);
            $readmemb(testcases[i],uut.imem.rom);
            
            if_instruction_fetch_en = $fopen({"../../results/saved_regs/",current_test,"_if_fetch_en"                          }, "r");
            if_branch_offset_imm    = $fopen({"../../results/saved_regs/",current_test,"_if_branch_offset_imm"                 }, "r");
            if_branch_taken         = $fopen({"../../results/saved_regs/",current_test,"_if_branch_taken"                      }, "r");
            if_pc                   = $fopen({"../../results/saved_regs/",current_test,"_pc"                                   }, "r");
            if_instruction          = $fopen({"../../results/saved_regs/",current_test,"_id_instruction"                       }, "r");

            while( !$feof(if_instruction_fetch_en) )
            begin
                $fscanf(if_instruction_fetch_en ,"%b\n" , temp_instruction_fetch_en       ); 
                $fscanf(if_branch_offset_imm    ,"%b\n" , temp_branch_offset_imm          ); 
                $fscanf(if_branch_taken         ,"%b\n" , temp_branch_taken               ); 
                $fscanf(if_pc                   ,"%b\n" , temp_pc                         ); 
                $fscanf(if_instruction          ,"%b\n" , temp_instruction                ); 
                
                //repeat(1) @(posedge clock);
                #1
                check_pc: assert( temp_pc === i_pc )
                else
                begin
                    $error("TEST %s - ERROR WHILE COMPARING OUTPUTS", test_name[i]); 
                    $display("************* temp_pc is %b i_pc is %b",temp_pc, i_pc);

                    current_test_errors +=1;
                end
                check_instruction: assert( temp_instruction ==? i_instruction )
                else
                begin
                    $error("TEST %s - ERROR WHILE COMPARING OUTPUTS", test_name[i]); 
                    $display("************* temp_instruction is %b i_instruction is %b",temp_instruction, i_instruction);
                    current_test_errors +=1;
                end
                repeat(1) @(posedge clock);
            end
            total_errors += current_test_errors;
            pass: assert ( current_test_errors == 0)
                $display("************* TEST %s PASSED!!!", test_name[i]);
            else
                $error("************* TEST %s FAILED!!!", test_name[i]);
            $fclose(if_instruction_fetch_en);
            $fclose(if_branch_offset_imm);
            $fclose(if_branch_taken);
            $fclose(if_pc);
            $fclose(if_instruction);
        end
        final_check: assert ( total_errors == 0 )
            $display("*********** IF STAGE UNIT TESTCASES PASSED!!!! *********** ");
        else
            $error("*********** IF STAGE TESTCASES FAILED!!!! *********** ");
        $stop();
    end

    assign o_instruction_fetch_en   = temp_instruction_fetch_en;
    assign o_branch_offset_imm      = temp_branch_offset_imm;
    assign o_branch_taken           = temp_branch_taken;
    
    assign reset                = rst;
    task sys_reset;
        begin
            rst = 1;
            #(CLK_PERIOD*2) rst = 0;            
        end
    endtask

endprogram


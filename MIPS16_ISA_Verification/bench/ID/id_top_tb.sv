`timescale 1ns/1ps
`include "mips_16_defs.v"

program id_top_tb(
    output                  reset,
    output                  o_instruction_decode_en,
    output [15:0]           o_instruction,
    input  [56:0]           i_pipeline_reg_out,
    input  [5:0]            i_branch_offset_imm,
    input                   i_branch_taken,
    input  [2:0]            i_reg_read_addr_1, 
    input  [2:0]            i_reg_read_addr_2, 
    output [15:0]           o_reg_read_data_1,
    output [15:0]           o_reg_read_data_2,  
    input  [2:0]            i_decoding_op_src1, 
    input  [2:0]            i_decoding_op_src2, 
    input                   clock
);
    localparam              N_TESTS = 14;
    localparam              CLK_PERIOD   = 10;
    string                  test_name[N_TESTS] = '{ 
                                                    "nop",
                                                    "addi",
                                                    "sub",
                                                    "and",
                                                    "or",
                                                    "xor",
                                                    "sl",
                                                    "sr",
                                                    "sru",
                                                    "add",
                                                    "R0_load",
                                                    "R1_load_store",
                                                    "branch_taken",
                                                    "branch_not_taken"
                                                };

    string                  current_test;
    logic                   rst;
    integer                 id_instruction_decode_en;
    integer                 id_branch_offset_imm;
    integer                 id_branch_taken;
    integer                 id_pipeline_reg_out;
    integer                 id_instruction;  
    integer                 id_reg_read_addr_1;  
    integer                 id_reg_read_addr_2;  
    integer                 id_reg_read_data_1;  
    integer                 id_reg_read_data_2;  
    integer                 id_decoding_op_src1; 
    integer                 id_decoding_op_src2; 

    int                     current_test_errors = 0;
    int                     total_errors;      

    logic                   temp_instruction_decode_en;
    logic  [5:0]            temp_branch_offset_imm;
    logic                   temp_branch_taken;
    logic  [56:0]           temp_pipeline_reg_out;
    logic  [15:0]           temp_instruction;
    logic  [15:0]           temp_reg_read_data_1;
    logic  [15:0]           temp_reg_read_data_2;  
    logic  [2:0]            temp_reg_read_addr_1;
    logic  [2:0]            temp_reg_read_addr_2;  
    logic  [2:0]            temp_decoding_op_src1;
    logic  [2:0]            temp_decoding_op_src2;  

    initial 
    begin
        for(int i = 0; i < N_TESTS; i++ )
        begin
            current_test            = test_name[i];
            current_test_errors     = 0;
            sys_reset;
            id_instruction_decode_en= $fopen({"../../results/saved_regs/",current_test,"_id_decode_en"                         }, "r");
            id_branch_offset_imm    = $fopen({"../../results/saved_regs/",current_test,"_if_branch_offset_imm"                 }, "r");
            id_branch_taken         = $fopen({"../../results/saved_regs/",current_test,"_if_branch_taken"                      }, "r");
            id_pipeline_reg_out     = $fopen({"../../results/saved_regs/",current_test,"_ex_pipeline_reg_in"                   }, "r");
            id_instruction          = $fopen({"../../results/saved_regs/",current_test,"_id_instruction"                       }, "r");

            id_reg_read_addr_1      = $fopen({"../../results/saved_regs/",current_test,"_rf_read_addr_1"                    }, "r");
            id_reg_read_addr_2      = $fopen({"../../results/saved_regs/",current_test,"_rf_read_addr_2"                    }, "r");
            id_reg_read_data_1      = $fopen({"../../results/saved_regs/",current_test,"_id_reg_read_data_1"                    }, "r");
            id_reg_read_data_2      = $fopen({"../../results/saved_regs/",current_test,"_id_reg_read_data_2"                    }, "r");
            id_decoding_op_src1     = $fopen({"../../results/saved_regs/",current_test,"_hazard_decoding_op_src1"                   }, "r");
            id_decoding_op_src2     = $fopen({"../../results/saved_regs/",current_test,"_hazard_decoding_op_src2"                   }, "r");

            while( !$feof(id_instruction_decode_en) )
            begin
                $fscanf(id_instruction_decode_en,"%b\n" , temp_instruction_decode_en      ); 
                $fscanf(id_branch_offset_imm    ,"%b\n" , temp_branch_offset_imm          ); 
                $fscanf(id_branch_taken         ,"%b\n" , temp_branch_taken               ); 
                $fscanf(id_pipeline_reg_out     ,"%b\n" , temp_pipeline_reg_out           ); 
                $fscanf(id_instruction          ,"%b\n" , temp_instruction                ); 

                $fscanf(id_reg_read_addr_1      ,"%b\n" , temp_reg_read_addr_1            );
                $fscanf(id_reg_read_addr_2      ,"%b\n" , temp_reg_read_addr_2            );
                $fscanf(id_reg_read_data_1      ,"%b\n" , temp_reg_read_data_1            );
                $fscanf(id_reg_read_data_2      ,"%b\n" , temp_reg_read_data_2            );
                $fscanf(id_decoding_op_src1     ,"%b\n" , temp_decoding_op_src1           );
                $fscanf(id_decoding_op_src2     ,"%b\n" , temp_decoding_op_src2           );
                
                //repeat(1) @(posedge clock);
                #1
                check_pipeline_reg_out: assert( temp_pipeline_reg_out ==? i_pipeline_reg_out )
                else
                begin
                    $error("TEST %s - ERROR WHILE COMPARING OUTPUTS", test_name[i]); 
                    $display("************* temp_pipeline_reg_out is %b i_pipeline_reg_out is %b",temp_pipeline_reg_out, i_pipeline_reg_out);

                    current_test_errors +=1;
                end

                check_branch_offset_imm: assert( temp_branch_offset_imm ==? i_branch_offset_imm )
                else
                begin
                    $error("TEST %s - ERROR WHILE COMPARING OUTPUTS", test_name[i]); 
                    $display("************* temp_branch_offset_imm is %b i_branch_offset_imm is %b",temp_branch_offset_imm, i_branch_offset_imm);
                    current_test_errors +=1;
                end

                check_branch_taken: assert( temp_branch_taken ==? i_branch_taken )
                else
                begin
                    $error("TEST %s - ERROR WHILE COMPARING OUTPUTS", test_name[i]); 
                    $display("************* temp_branch_taken is %b i_branch_taken is %b",temp_branch_taken, i_branch_taken);
                    current_test_errors +=1;
                end

                check_reg_read_addr_1: assert( temp_reg_read_addr_1 ==? i_reg_read_addr_1 )
                else
                begin
                    $error("TEST %s - ERROR WHILE COMPARING OUTPUTS", test_name[i]); 
                    $display("************* temp_breg_read_addr_1 is %b i_reg_read_addr_1 is %b",temp_reg_read_addr_1, i_reg_read_addr_1);
                    current_test_errors +=1;
                end

                check_reg_read_addr_2: assert( temp_reg_read_addr_2 ==? i_reg_read_addr_2 )
                else
                begin
                    $error("TEST %s - ERROR WHILE COMPARING OUTPUTS", test_name[i]); 
                    $display("************* temp_reg_read_addr_2 is %b i_reg_read_addr_2 is %b",temp_reg_read_addr_2, i_reg_read_addr_2);
                    current_test_errors +=1;
                end

                check_decoding_op_src1: assert( temp_decoding_op_src1 ==? i_decoding_op_src1 )
                else
                begin
                    $error("TEST %s - ERROR WHILE COMPARING OUTPUTS", test_name[i]); 
                    $display("************* temp_decoding_op_src1 is %b i_decoding_op_src1 is %b",temp_decoding_op_src1, i_reg_read_addr_2);
                    current_test_errors +=1;
                end

                check_decoding_op_src2: assert( temp_reg_read_addr_2 ==? i_reg_read_addr_2 )
                else
                begin
                    $error("TEST %s - ERROR WHILE COMPARING OUTPUTS", test_name[i]); 
                    $display("************* temp_reg_read_addr_2 is %b i_reg_read_addr_2 is %b",temp_reg_read_addr_2, i_reg_read_addr_2);
                    current_test_errors +=1;
                end                
                repeat(1) @(posedge clock);
            end
            total_errors += current_test_errors;
            pass: assert ( current_test_errors == 0)
                $display("************* TEST %s PASSED!!!", test_name[i]);
            else
                $error("************* TEST %s FAILED!!!", test_name[i]);
            $fclose(id_instruction_decode_en);
            $fclose(id_branch_offset_imm);
            $fclose(id_branch_taken);
            $fclose(id_pipeline_reg_out);
            $fclose(id_instruction);

            $fclose(id_reg_read_addr_1);
            $fclose(id_reg_read_addr_2);
            $fclose(id_reg_read_data_1);
            $fclose(id_reg_read_data_2);
            $fclose(id_decoding_op_src1);
            $fclose(id_decoding_op_src2);

        end
        final_check: assert ( total_errors == 0 )
            $display("*********** ID STAGE UNIT TESTCASES PASSED!!!! *********** ");
        else
            $error("*********** ID STAGE TESTCASES FAILED!!!! *********** ");
        $stop();
    end

    assign o_instruction            = temp_instruction;
    assign o_instruction_decode_en   = temp_instruction_decode_en;
    assign i_branch_taken           = temp_branch_taken;
    assign o_reg_read_data_1        = temp_reg_read_data_1;
    assign o_reg_read_data_2        = temp_reg_read_data_2;
    
    assign reset                = rst;
    task sys_reset;
        begin
            rst = 1;
            #(CLK_PERIOD*2) rst = 0;            
        end
    endtask

endprogram


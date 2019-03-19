`timescale 1ns/1ps
`include "mips_16_defs.v"

program mem_top_tb(
    input                   reset,
    input  [2:0]           i_mem_op_dest,
    input  [36:0]          i_pipeline_reg_out,
    output   [37:0]         o_pipeline_reg_in,
    input                   clock
);




    localparam              N_TESTS = 8;
    localparam              CLK_PERIOD   = 10;
    string                  test_name[N_TESTS] = '{ 
                                                    "R0_load",
                                                    "R1_load_store",
                                                    "R2_load_store",
                                                    "R3_load_store",
                                                    "R4_load_store",
                                                    "R5_load_store",
                                                    "R6_load_store",
                                                    "R7_load_store"
                                                };

    string                  current_test;
    logic                   rst;
    integer                 memory_mem_op_dest;
    integer                 memory_pipeline_reg_out;
    integer                 memory_pipeline_reg_in;

    int                     current_test_errors = 0;
    int                     total_errors;      

    logic  [37:0]   temp_pipeline_reg_in;
    logic  [36:0]   temp_pipeline_reg_out;
    logic  [2:0]    temp_mem_op_dest;    

    initial 
    begin
        for(int i = 0; i < N_TESTS; i++ )
        begin
            current_test            = test_name[i];
            current_test_errors     = 0;
            sys_reset;
            memory_mem_op_dest      = $fopen({"../../results/saved_regs/",current_test,"_hazard_mem_op_dest"                   }, "r");
            memory_pipeline_reg_out = $fopen({"../../results/saved_regs/",current_test,"_wb_pipeline_reg_in"              }, "r");
            memory_pipeline_reg_in  = $fopen({"../../results/saved_regs/",current_test,"_mem_pipeline_reg_in"        }, "r");
            


            while( !$feof(memory_mem_op_dest) )
            begin
                $fscanf(memory_mem_op_dest ,"%b\n" , temp_mem_op_dest); 
                $fscanf(memory_pipeline_reg_out,"%b\n" , temp_pipeline_reg_out); 
                $fscanf(memory_pipeline_reg_in,"%b\n" , temp_pipeline_reg_in); 
                 
                //repeat(1) @(posedge clock);
                #1
                check_mem_op_dest: assert( temp_mem_op_dest ==? i_mem_op_dest )
                else
                begin
                    $error("TEST %s - ERROR WHILE COMPARING OUTPUTS", test_name[i]); 
                    $display("************* temp_mem_op_dest is %b i_mem_op_dest is %b",temp_mem_op_dest, i_mem_op_dest);

                    current_test_errors +=1;
                end

                check_instruction: assert( temp_pipeline_reg_out ==? i_pipeline_reg_out)
                else
                begin
                    $error("TEST %s - ERROR WHILE COMPARING OUTPUTS", test_name[i]); 
                    $display("************* Temp_pipeline_reg_out is %b i_pipeline_reg_out is %b",temp_pipeline_reg_out, i_pipeline_reg_out);
                    current_test_errors +=1;
                end

                repeat(1) @(posedge clock);
                
            end
            total_errors += current_test_errors;
            pass: assert ( current_test_errors == 0)
                $display("************* TEST %s PASSED!!!", test_name[i]);
            else
                $error("************* TEST %s FAILED!!!", test_name[i]);
            $fclose(memory_mem_op_dest);
            $fclose(memory_pipeline_reg_out);
            $fclose(memory_pipeline_reg_in);
        
        end
        final_check: assert ( total_errors == 0 )
            $display("*********** MEM STAGE UNIT TESTCASES PASSED!!!! *********** ");
        else
            $error("*********** MEM STAGE TESTCASES FAILED!!!! *********** ");
        $stop();
    end

    assign o_pipeline_reg_in   =     temp_pipeline_reg_in;

    
    assign reset                = rst;
    task sys_reset;
        begin
            rst = 1;
            #(CLK_PERIOD*2) rst = 0;            
        end
    endtask

endprogram


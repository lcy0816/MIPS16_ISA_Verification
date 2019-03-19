`timescale 1ns/1ps
`include "mips_16_defs.v"

program wb_top_tb(
    input clock,
    output reset,
    input                  i_reg_write_en,
    input      [2:0]       i_reg_write_dest,
    input      [15:0]      i_reg_write_data,
    
    input      [2:0]       i_wb_op_dest,
   
    output   [36:0]        o_pipeline_reg_in
);




    localparam              N_TESTS = 19;
    localparam              CLK_PERIOD   = 10;
    string                  test_name[N_TESTS] = '{ 
                                                    "R0_load",
                                                    "R1_load_store",
                                                    "R2_load_store",
                                                    "R3_load_store",
                                                    "R4_load_store",
                                                    "R5_load_store",
                                                    "R6_load_store",
                                                    "R7_load_store",
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
                                                    "hazard_detection"                                               
                                                };

    string                  current_test;
    logic                   rst;

    integer                 writeback_reg_write_dest;
    integer                 writeback_reg_write_data;
    integer                 writeback_wb_op_dest;
    integer                 writeback_reg_write_en;
    integer                 writeback_pipeline_reg_in;

    int                     current_test_errors = 0;
    int                     total_errors;      

    logic                  temp_reg_write_en;
    logic      [2:0]       temp_reg_write_dest;
    logic      [15:0]      temp_reg_write_data;
    
    logic      [2:0]       temp_wb_op_dest;
   
    logic   [36:0]         temp_pipeline_reg_in;    

    initial 
    begin
        for(int i = 0; i < N_TESTS; i++ )
        begin
            current_test            = test_name[i];
            current_test_errors     = 0;
            sys_reset;
            writeback_reg_write_dest    = $fopen({"../../results/saved_regs/",current_test,"_rf_write_dest"}, "r");
            writeback_reg_write_data    = $fopen({"../../results/saved_regs/",current_test,"_rf_write_data"}, "r");
            writeback_reg_write_en      = $fopen({"../../results/saved_regs/",current_test,"_rf_write_en"}, "r");
            writeback_wb_op_dest        = $fopen({"../../results/saved_regs/",current_test,"_hazard_wb_op_dest"}, "r");
            writeback_pipeline_reg_in   = $fopen({"../../results/saved_regs/",current_test,"_wb_pipeline_reg_in"}, "r");
            

            while( !$feof(writeback_reg_write_data)) 
            begin
                $fscanf(writeback_reg_write_dest    ,"%b\n" , temp_reg_write_dest); 
                $fscanf(writeback_reg_write_data    ,"%b\n" , temp_reg_write_data ); 
                $fscanf(writeback_reg_write_en      ,"%b\n" , temp_reg_write_en );
                $fscanf(writeback_wb_op_dest        ,"%b\n" , temp_wb_op_dest ); 
                $fscanf(writeback_pipeline_reg_in   ,"%b\n" , temp_pipeline_reg_in); 
                //repeat(1) @(posedge clock);
                #1
                check_reg_write_dest: assert( temp_reg_write_dest ==? i_reg_write_dest )
                else
                begin
                    $error("TEST %s - ERROR WHILE COMPARING OUTPUTS", test_name[i]); 
                    $display("************* temp_reg_write_dest is %b i_reg_write_dest is %b",temp_reg_write_dest, i_reg_write_dest);

                    current_test_errors +=1;
                end

                check_reg_write_en: assert( temp_reg_write_en ==? i_reg_write_en )
                else
                begin
                    $error("TEST %s - ERROR WHILE COMPARING OUTPUTS", test_name[i]); 
                    $display("************* temp_reg_write_en is %b i_reg_write_en is %b",temp_reg_write_en, i_reg_write_en);
                    current_test_errors +=1;
                end
                
                check_reg_write_data: assert( temp_reg_write_data ==? i_reg_write_data )
                else
                begin
                    $error("TEST %s - ERROR WHILE COMPARING OUTPUTS", test_name[i]); 
                    $display("************* temp_reg_write_data is %b i_reg_write_data is %b",temp_reg_write_data, i_reg_write_data);
                    current_test_errors +=1;
                end
                check_wb_op_dest: assert( temp_wb_op_dest ==? i_wb_op_dest )
                else
                begin
                    $error("TEST %s - ERROR WHILE COMPARING OUTPUTS", test_name[i]); 
                    $display("************* temp_wb_op_dest is %b i_wb_op_dest is %b",temp_wb_op_dest, i_wb_op_dest);
                    current_test_errors +=1;
                end
                repeat(1) @(posedge clock);
            end
            total_errors += current_test_errors;
            pass: assert ( current_test_errors == 0)
                $display("************* TEST %s PASSED!!!", test_name[i]);
            else
                $error("************* TEST %s FAILED!!!", test_name[i]);
            $fclose(writeback_reg_write_dest);
            $fclose(writeback_reg_write_data);
            $fclose(writeback_reg_write_en);
            $fclose(writeback_wb_op_dest);
            $fclose(writeback_pipeline_reg_in);
        end
        final_check: assert ( total_errors == 0 )
            $display("*********** IF STAGE UNIT TESTCASES PASSED!!!! *********** ");
        else
            $error("*********** IF STAGE TESTCASES FAILED!!!! *********** ");
        $stop();
    end

    assign  o_pipeline_reg_in  =  temp_pipeline_reg_in;  
    
    assign reset                = rst;
    task sys_reset;
        begin
            rst = 1;
            #(CLK_PERIOD*2) rst = 0;            
        end
    endtask

endprogram


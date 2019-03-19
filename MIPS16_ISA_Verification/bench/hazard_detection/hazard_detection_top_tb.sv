`timescale 1ns/1ps
program hazard_detection_top_tb( //[TOCHECK] should run in the reactive region?
    output          reset,
    output  [2:0]   o_decoding_op_src1,
    output  [2:0]   o_decoding_op_src2,
    output  [2:0]   o_ex_op_dest,
    output  [2:0]   o_mem_op_dest,
    output  [2:0]   o_wb_op_dest,
    input           i_pipeline_stall_n,
    input           clock
);
    localparam              N_TESTS = 9;
    localparam              CLK_PERIOD   = 10;
    string                  test_name[N_TESTS] = '{ 
                                                    "hazard_r0",
                                                    "hazard_r1",
                                                    "hazard_r2",
                                                    "hazard_r3",
                                                    "hazard_r4",
                                                    "hazard_r5",
                                                    "hazard_r6",
                                                    "hazard_r7",
                                                    "hazard_detection"
                                                };

    string                  current_test;
    logic                   rst;
    integer                 hazard_decoding_op_src1;
    integer                 hazard_decoding_op_src2;
    integer                 hazard_ex_op_dest;
    integer                 hazard_mem_op_dest;
    integer                 hazard_wb_op_dest;
    integer                 if_fetch_en;  
    logic                   read_pipeline_stall_n;  

    int                     current_test_errors = 0;
    int                     total_errors;      

    logic   [2:0]           src1;
    logic   [2:0]           src2;
    logic   [2:0]           ex_dest;
    logic   [2:0]           mem_dest;
    logic   [2:0]           wb_dest;

    initial 
    begin
        for(int i = 0; i < N_TESTS; i++ )
        begin
            current_test            = test_name[i];
            current_test_errors     = 0;
            sys_reset;
            if_fetch_en             = $fopen({"../../results/saved_regs/",current_test,"_if_fetch_en"               }, "r");
            hazard_decoding_op_src1 = $fopen({"../../results/saved_regs/",current_test,"_hazard_decoding_op_src1"   }, "r");
            hazard_decoding_op_src2 = $fopen({"../../results/saved_regs/",current_test,"_hazard_decoding_op_src2"   }, "r");
            hazard_ex_op_dest       = $fopen({"../../results/saved_regs/",current_test,"_hazard_ex_op_dest"         }, "r");
            hazard_mem_op_dest      = $fopen({"../../results/saved_regs/",current_test,"_hazard_mem_op_dest"        }, "r");
            hazard_wb_op_dest       = $fopen({"../../results/saved_regs/",current_test,"_hazard_wb_op_dest"         }, "r");
            while( !$feof(hazard_decoding_op_src1) )
            begin
                $fscanf(hazard_decoding_op_src1 ,"%b\n" , src1          ); 
                $fscanf(hazard_decoding_op_src2 ,"%b\n" , src2          ); 
                $fscanf(hazard_ex_op_dest       ,"%b\n" , ex_dest       ); 
                $fscanf(hazard_mem_op_dest      ,"%b\n" , mem_dest      ); 
                $fscanf(hazard_wb_op_dest       ,"%b\n" , wb_dest       ); 
                $fscanf(if_fetch_en             ,"%b\n" , read_pipeline_stall_n );
                repeat(1) @(posedge clock);
                check_output: assert( read_pipeline_stall_n === i_pipeline_stall_n )
                else
                begin
                    $error("TEST %s - ERROR WHILE COMPARING OUTPUTS", test_name[i]); 
                    current_test_errors +=1;
                end
            end
            total_errors += current_test_errors;
            pass: assert ( current_test_errors == 0)
                $display("************* TEST %s PASSED!!!", test_name[i]);
            else
                $error("************* TEST %s FAILED!!!", test_name[i]);
            $fclose(hazard_decoding_op_src1);
            $fclose(hazard_decoding_op_src2);
            $fclose(hazard_ex_op_dest);
            $fclose(hazard_mem_op_dest);
            $fclose(hazard_wb_op_dest);
            $fclose(if_fetch_en);
        end
        final_check: assert ( total_errors == 0 )
            $display("*********** HAZARD DETECTION UNIT TESTCASES PASSED!!!! *********** ");
        else
            $error("*********** HAZARD DETECTION UNIT TESTCASES FAILED!!!! *********** ");
        $stop();
    end

    assign o_decoding_op_src1   = src1;
    assign o_decoding_op_src2   = src2;
    assign o_ex_op_dest         = ex_dest;
    assign o_mem_op_dest        = mem_dest;
    assign o_wb_op_dest         = wb_dest;
    assign reset                = rst;
    task sys_reset;
        begin
            rst = 1;
            #(CLK_PERIOD*2) rst = 0;            
        end
    endtask

endprogram


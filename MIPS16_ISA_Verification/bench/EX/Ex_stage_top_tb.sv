`timescale 1ns/1ps
program Ex_stage_top_tb(
        output              reset,
        output  [56:0]      reg_pipeline_in,
        input   [37:0]      reg_pipeline_out,
        input   [2 :0]      op_ex_dest,        
        input               clock
);

    localparam              N_TESTS = 8;
    localparam              CLK_PERIOD   = 10;
    string                  test_name[N_TESTS] = '{ 
                                                    "add",
                                                    "sub",
                                                    "and",
                                                    "or",
                                                    "xor",
                                                    "sl",
                                                    "sr",
                                                    "sru"
                                                };
    string                  current_test;
    logic                   rst;     
    integer                 alu_reg_pipeline_in;
    integer                 alu_reg_pipeline_out;
    integer                 alu_op_ex_dest;
    

        
    int                     current_test_errors;
    int                     total_errors;
    
    logic [56:0]            pipeline_in;
    logic [37:0]            pipeline_out;
    logic [2 :0]            ex_dest;
      
    initial 
    begin
        for(int i = 0; i < N_TESTS; i++ )
        begin
            current_test            = test_name[i];
            current_test_errors     = 0;
            sys_reset;
            
            
            alu_reg_pipeline_in     = $fopen({"../../results/saved_regs/",current_test,"_ex_pipeline_reg_in"   }, "r");
            alu_reg_pipeline_out    = $fopen({"../../results/saved_regs/",current_test,"_mem_pipeline_reg_in"   }, "r");
            alu_op_ex_dest          = $fopen({"../../results/saved_regs/",current_test,"_hazard_ex_op_dest"   }, "r");

            
            while( !$feof(alu_reg_pipeline_in) )
            begin
                
                $fscanf(alu_reg_pipeline_in,    "%b\n", pipeline_in             );
                $fscanf(alu_reg_pipeline_out,   "%b\n", pipeline_out            ); 
                $fscanf(alu_op_ex_dest,         "%b\n", ex_dest                 );  
                
                #1
                check_op_dest: assert(ex_dest ==? op_ex_dest)   
                else
                begin
                    $error("TEST %s - ERROR WHILE COMPARING OUTPUTS", test_name[i]); 
                    $display("READ VALUE %h INPUT VALUE %h", ex_dest, op_ex_dest );
                    current_test_errors +=1;
                end
                                
                check_pipeline_out: assert( pipeline_out ==? reg_pipeline_out )
                else
                begin
                    $error("TEST %s - ERROR WHILE COMPARING OUTPUTS", test_name[i]); 
                    $display("READ VALUE %h INPUT VALUE %h", pipeline_out, reg_pipeline_out );
                    current_test_errors +=1;
                end
                repeat(1) @(posedge clock);
            end
            total_errors += current_test_errors;     
            pass: assert ( current_test_errors == 0)
                $display("************* TEST %s PASSED!!!", test_name[i]);
            else
                $error("************* TEST %s FAILED!!!", test_name[i]);
            
            $fclose(alu_reg_pipeline_in);
            $fclose(alu_reg_pipeline_out);
            $fclose(alu_op_ex_dest);
            
        end

        final_check: assert ( total_errors == 0 )
            $display("*********** HAZARD DETECTION UNIT TESTCASES PASSED!!!! *********** ");
        else
            $error("*********** HAZARD DETECTION UNIT TESTCASES FAILED!!!! *********** ");
        $stop();
    end

    assign reg_pipeline_in      = pipeline_in;
    assign reset                = rst;
    task sys_reset;
        begin
            rst = 1;
            #(CLK_PERIOD*2) rst = 0;            
        end
    endtask

endprogram

                

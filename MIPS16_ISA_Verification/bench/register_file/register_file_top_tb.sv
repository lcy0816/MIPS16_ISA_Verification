`timescale 1ns/1ps
program register_file_top_tb( 
    output          reset,
    output          o_reg_write_en      ,
    output  [2 :0]  o_reg_write_dest    ,
    output  [15:0]  o_reg_write_data    ,
    output  [2 :0]  o_reg_read_addr_1   ,
    output  [2 :0]  o_reg_read_addr_2   ,
    input   [15:0]  i_reg_read_data_1   ,
    input   [15:0]  i_reg_read_data_2   ,
    input           clock
);
    localparam              N_TESTS = 27;
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
                                                    "hazard_detection",
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
                                                    "R2_load_store",
                                                    "R3_load_store",
                                                    "R4_load_store",
                                                    "R5_load_store",
                                                    "R6_load_store",
                                                    "R7_load_store"                                                    
                                                };

    string                  current_test;
    logic                   rst;
    integer                 rf_write_en     ;
    integer                 rf_write_dest   ;
    integer                 rf_write_data   ;
    integer                 rf_read_addr_1  ;
    integer                 rf_read_addr_2  ;
    integer                 id_reg_read_data_1;
    integer                 id_reg_read_data_2;

    //to outputs
    logic                   reg_write_en    ;
    logic   [2 :0]          reg_write_dest  ;
    logic   [15:0]          reg_write_data  ;
    logic   [2 :0]          reg_read_addr_1 ;
    logic   [2 :0]          reg_read_addr_2 ;
    //to compare inputs
    logic   [15:0]          reg_read_data_1 ;
    logic   [15:0]          reg_read_data_2 ;
    
    int                     current_test_errors = 0;
    int                     total_errors;      


    initial 
    begin
        for(int i = 0; i < N_TESTS; i++ )
        begin
            current_test            = test_name[i];
            current_test_errors     = 0;
            sys_reset;
            rf_write_en             = $fopen({"../../results/saved_regs/",current_test,"_rf_write_en"               }, "r");
            rf_write_dest           = $fopen({"../../results/saved_regs/",current_test,"_rf_write_dest"             }, "r");
            rf_write_data           = $fopen({"../../results/saved_regs/",current_test,"_rf_write_data"             }, "r");
            rf_read_addr_1          = $fopen({"../../results/saved_regs/",current_test,"_rf_read_addr_1"            }, "r");
            rf_read_addr_2          = $fopen({"../../results/saved_regs/",current_test,"_rf_read_addr_2"            }, "r");
            id_reg_read_data_1      = $fopen({"../../results/saved_regs/",current_test,"_id_reg_read_data_1"        }, "r");
            id_reg_read_data_2      = $fopen({"../../results/saved_regs/",current_test,"_id_reg_read_data_2"        }, "r");
        
            while( !$feof(rf_write_en) )
            begin
                $fscanf(rf_write_en        ,"%b\n" , reg_write_en           ); 
                $fscanf(rf_write_dest      ,"%b\n" , reg_write_dest         ); 
                $fscanf(rf_write_data      ,"%b\n" , reg_write_data         ); 
                $fscanf(rf_read_addr_1     ,"%b\n" , reg_read_addr_1        ); 
                $fscanf(rf_read_addr_2     ,"%b\n" , reg_read_addr_2        ); 
                #1
                $fscanf(id_reg_read_data_1 ,"%b\n" , reg_read_data_1        );
                $fscanf(id_reg_read_data_2 ,"%b\n" , reg_read_data_2        );
                //repeat(1) @(posedge clock);
                check_output_read_data_1: assert( reg_read_data_1 === i_reg_read_data_1 )
                else
                begin
                    $error("TEST %s - ERROR WHILE COMPARING OUTPUTS", test_name[i]); 
                    $display("INPUT DATA %b EXPECTED %b", reg_read_data_1, i_reg_read_data_1 );
                    current_test_errors +=1;
                end
                check_output_read_data_2: assert( reg_read_data_2 === i_reg_read_data_2 )
                else
                begin
                    $error("TEST %s - ERROR WHILE COMPARING OUTPUTS", test_name[i]); 
                    $display("INPUT DATA %b EXPECTED %b", reg_read_data_2, i_reg_read_data_2 );
                    current_test_errors +=1;
                end
                repeat(1) @(posedge clock);
            end
            total_errors += current_test_errors;
            if( current_test_errors != 0)
                $error("************* TEST %s FAILED!!!", test_name[i]);
            else
                $display("************* TEST %s PASSED!!!", test_name[i]);
            $fclose(rf_write_en         );
            $fclose(rf_write_dest       );
            $fclose(rf_write_data       );
            $fclose(rf_read_addr_1      );
            $fclose(rf_read_addr_2      );
            $fclose(id_reg_read_data_1  );
            $fclose(id_reg_read_data_2  );
            
        end
        if( total_errors != 0 )
            $error("*********** REGISTER FILE UNIT TESTCASES FAILED!!!! *********** ");
        else
            $display("*********** REGISTER FILE UNIT TESTCASES PASSED!!!! *********** ");
        $stop();
    end

    assign o_reg_write_en       = reg_write_en   ;
    assign o_reg_write_dest     = reg_write_dest ;
    assign o_reg_write_data     = reg_write_data ;
    assign o_reg_read_addr_1    = reg_read_addr_1;
    assign o_reg_read_addr_2    = reg_read_addr_2;
    assign reset                = rst;
    task sys_reset;
        begin
            rst = 1;
            #(CLK_PERIOD*2) rst = 0;            
        end
    endtask

endprogram


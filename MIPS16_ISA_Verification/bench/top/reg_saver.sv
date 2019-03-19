module reg_saver
#(
    parameter       SAVE_REGS=0
)(  //[TOCHECK]Need to act in the reactive region 
    input   clk, 
    input   rst,
    input   string current_test
);
    //how about reset?
    integer if_fetch_en;
    integer if_branch_offset_imm;
    integer if_branch_taken;

    integer id_decode_en;
    integer id_instruction;
    integer id_reg_read_data_1;
    integer id_reg_read_data_2;

    integer ex_pipeline_reg_in;

    integer mem_pipeline_reg_in;

    integer wb_pipeline_reg_in;

    integer hazard_decoding_op_src1;
    integer hazard_decoding_op_src2;
    integer hazard_ex_op_dest;
    integer hazard_mem_op_dest;
    integer hazard_wb_op_dest;

    integer rf_write_en     ;
    integer rf_write_dest   ;
    integer rf_write_data   ;
    integer rf_read_addr_1  ;
    integer rf_read_addr_2  ;

    integer pc;

generate
    if( SAVE_REGS )
    begin
        always_ff@(posedge clk, posedge rst)
        if( rst )
        begin
            $fclose( if_fetch_en             );
            $fclose( if_branch_offset_imm    );
            $fclose( if_branch_taken         );
            $fclose( id_decode_en            );
            $fclose( id_instruction          );
            $fclose( id_reg_read_data_1      );
            $fclose( id_reg_read_data_2      );
            $fclose( ex_pipeline_reg_in      );
            $fclose( mem_pipeline_reg_in     );
            $fclose( wb_pipeline_reg_in      );
            $fclose( hazard_decoding_op_src1 );
            $fclose( hazard_decoding_op_src2 );
            $fclose( hazard_ex_op_dest       );
            $fclose( hazard_mem_op_dest      );
            $fclose( hazard_wb_op_dest       );
            $fclose( rf_write_en             );
            $fclose( rf_write_dest           );
            $fclose( rf_write_data           );
            $fclose( rf_read_addr_1          );
            $fclose( rf_read_addr_2          );
            $fclose( pc                      );
            if_fetch_en             = $fopen({"../../results/saved_regs/",current_test,"_if_fetch_en"               }, "w");
            if_branch_offset_imm    = $fopen({"../../results/saved_regs/",current_test,"_if_branch_offset_imm"      }, "w");       
            if_branch_taken         = $fopen({"../../results/saved_regs/",current_test,"_if_branch_taken"           }, "w");
            id_decode_en            = $fopen({"../../results/saved_regs/",current_test,"_id_decode_en"              }, "w");
            id_instruction          = $fopen({"../../results/saved_regs/",current_test,"_id_instruction"            }, "w");
            id_reg_read_data_1      = $fopen({"../../results/saved_regs/",current_test,"_id_reg_read_data_1"        }, "w");
            id_reg_read_data_2      = $fopen({"../../results/saved_regs/",current_test,"_id_reg_read_data_2"        }, "w");
            ex_pipeline_reg_in      = $fopen({"../../results/saved_regs/",current_test,"_ex_pipeline_reg_in"        }, "w");
            mem_pipeline_reg_in     = $fopen({"../../results/saved_regs/",current_test,"_mem_pipeline_reg_in"       }, "w");
            wb_pipeline_reg_in      = $fopen({"../../results/saved_regs/",current_test,"_wb_pipeline_reg_in"        }, "w");
            hazard_decoding_op_src1 = $fopen({"../../results/saved_regs/",current_test,"_hazard_decoding_op_src1"   }, "w");
            hazard_decoding_op_src2 = $fopen({"../../results/saved_regs/",current_test,"_hazard_decoding_op_src2"   }, "w");
            hazard_ex_op_dest       = $fopen({"../../results/saved_regs/",current_test,"_hazard_ex_op_dest"         }, "w");
            hazard_mem_op_dest      = $fopen({"../../results/saved_regs/",current_test,"_hazard_mem_op_dest"        }, "w");
            hazard_wb_op_dest       = $fopen({"../../results/saved_regs/",current_test,"_hazard_wb_op_dest"         }, "w");
            rf_write_en             = $fopen({"../../results/saved_regs/",current_test,"_rf_write_en"               }, "w");
            rf_write_dest           = $fopen({"../../results/saved_regs/",current_test,"_rf_write_dest"             }, "w");
            rf_write_data           = $fopen({"../../results/saved_regs/",current_test,"_rf_write_data"             }, "w");
            rf_read_addr_1          = $fopen({"../../results/saved_regs/",current_test,"_rf_read_addr_1"            }, "w");
            rf_read_addr_2          = $fopen({"../../results/saved_regs/",current_test,"_rf_read_addr_2"            }, "w");
            pc                      = $fopen({"../../results/saved_regs/",current_test,"_pc"                        }, "w");

        end
        else
        begin
            $fdisplay( if_fetch_en              ,"%b", mips_16_top.uut.pipeline_stall_n);
            $fdisplay( if_branch_offset_imm     ,"%b", mips_16_top.uut.branch_offset_imm);
            $fdisplay( if_branch_taken          ,"%b", mips_16_top.uut.branch_taken);

            $fdisplay( id_decode_en             ,"%b", mips_16_top.uut.pipeline_stall_n);
            $fdisplay( id_instruction           ,"%b", mips_16_top.uut.instruction);
            $fdisplay( id_reg_read_data_1       ,"%b", mips_16_top.uut.reg_read_data_1);
            $fdisplay( id_reg_read_data_2       ,"%b", mips_16_top.uut.reg_read_data_2);

            $fdisplay( ex_pipeline_reg_in       ,"%b", mips_16_top.uut.ID_pipeline_reg_out);
            
            $fdisplay( mem_pipeline_reg_in      ,"%b", mips_16_top.uut.EX_pipeline_reg_out);

            $fdisplay( wb_pipeline_reg_in       ,"%b", mips_16_top.uut.MEM_pipeline_reg_out);

            $fdisplay( hazard_decoding_op_src1  ,"%b", mips_16_top.uut.decoding_op_src1);
            $fdisplay( hazard_decoding_op_src2  ,"%b", mips_16_top.uut.decoding_op_src2);
            $fdisplay( hazard_ex_op_dest        ,"%b", mips_16_top.uut.ex_op_dest);
            $fdisplay( hazard_mem_op_dest       ,"%b", mips_16_top.uut.mem_op_dest);
            $fdisplay( hazard_wb_op_dest        ,"%b", mips_16_top.uut.wb_op_dest);

            $fdisplay( rf_write_en              ,"%b", mips_16_top.uut.reg_write_en);
            $fdisplay( rf_write_dest            ,"%b", mips_16_top.uut.reg_write_dest);
            $fdisplay( rf_write_data            ,"%b", mips_16_top.uut.reg_write_data);
            $fdisplay( rf_read_addr_1           ,"%b", mips_16_top.uut.reg_read_addr_1);
            $fdisplay( rf_read_addr_2           ,"%b", mips_16_top.uut.reg_read_addr_2);

            $fdisplay( pc                       ,"%b", mips_16_top.uut.pc);
        end
    end
endgenerate


endmodule
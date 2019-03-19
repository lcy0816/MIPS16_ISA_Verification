`include "mips_16_defs.v"

program wb_assertions(
    input                  reg_write_en,
    input      [2:0]       reg_write_dest,
    input      [15:0]      reg_write_data,
    
    input      [2:0]       wb_op_dest,
   
    input     [36:0]        pipeline_reg_in,

    input                   clk,
    input                   rst
    

);

    wire [15:0] ex_alu_result = pipeline_reg_in[36:21];
    wire [15:0] mem_read_data = pipeline_reg_in[20:5];
    wire        write_back_en = pipeline_reg_in[4];
    wire [2:0]  write_back_dest = pipeline_reg_in[3:1];
    wire        write_back_result_mux = pipeline_reg_in[0];
    

    property wb_data_true;
        @(posedge clk) disable iff( rst )
            (write_back_result_mux==1) |-> reg_write_data === mem_read_data; 
    endproperty
    assert property (wb_data_true);
   wb_data_true_c: cover property (wb_data_true);

    property wb_data_false;
        @(posedge clk) disable iff( rst )
            (write_back_result_mux==0) |-> reg_write_data === ex_alu_result; 
    endproperty
    assert property (wb_data_false);
    wb_data_false_c: cover property (wb_data_false);

endprogram
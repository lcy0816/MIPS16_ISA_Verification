`timescale 1ns/1ps
`include "mips_16_defs.v"

module register_file_top();

    //Local variables
    logic           clk;
    logic           rst;
    logic           reg_write_en;
    logic   [2:0]   reg_write_dest;
    logic   [15:0]  reg_write_data;
    logic   [2:0]   reg_read_addr_1;
    logic   [15:0]  reg_read_data_1;
    logic   [2:0]   reg_read_addr_2;
    logic   [15:0]  reg_read_data_2;

    //Instances
    clock_generator u_clock_generator( .clock (clk) );
    register_file uut ( .*);
    register_file_top_tb u_register_file_top_tb( 
                                .reset                  ( rst               ),
                                .o_reg_write_en         ( reg_write_en      ),
                                .o_reg_write_dest       ( reg_write_dest    ),
                                .o_reg_write_data       ( reg_write_data    ),
                                .o_reg_read_addr_1      ( reg_read_addr_1   ),
                                .o_reg_read_addr_2      ( reg_read_addr_2   ),
                                .i_reg_read_data_1      ( reg_read_data_1   ),
                                .i_reg_read_data_2      ( reg_read_data_2   ),
                                .clock                  ( clk               )
                                );
    bind register_file register_file_assertions u_assertions( .* );    

endmodule
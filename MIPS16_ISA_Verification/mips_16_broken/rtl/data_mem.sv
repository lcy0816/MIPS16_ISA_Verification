/***************************************************
 * Module: data_mem
 * Project: mips_16
 * Author: fzy,TJ
 * Description: 
 *     a ram implementation, 16bit word width, address width can be configured be user
 *		further will be able to read external memory
 *
 * Revise history: 02/16/2019 TJ: Re-work with Interfaces
 *     
 ***************************************************/
`timescale 1ns/1ps
`include "mips_16_defs.v"
module data_mem
(
	mem_if.memory 			mif
);


	reg [15:0] ram [(2**`DATA_MEM_ADDR_WIDTH)-1:0];

	wire [`DATA_MEM_ADDR_WIDTH-1 : 0] ram_addr = mif.mem_access_addr[`DATA_MEM_ADDR_WIDTH-1 : 0];

	always @(posedge mif.clk)
		if (mif.mem_write_en)
			ram[ram_addr] <= mif.mem_write_data;

	assign mif.mem_read_data = ram[ram_addr]; 
   
endmodule 
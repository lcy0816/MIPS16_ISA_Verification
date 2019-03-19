/***************************************************
 * Module: MEM_stage
 * Project: mips_16
 * Author: fzy
 * Description: 
 *     a ram
 *
 * Revise history:
 *     
 ***************************************************/
`timescale 1ns/1ps
`include "mips_16_defs.v"

module MEM_stage
(
	input					clk,
	input					rst,
	
	// from EX_stage
	input		[37:0]		pipeline_reg_in,	//	[37:22],16bits:	miff.mem_access_addr[15:0];
												//	[21:5],17bits:	miff.mem_write_en, miff.mem_write_data[15:0]
												//	[4:0],5bits:	write_back_en, write_back_dest[2:0], write_back_result_mux, 
	
	// to WB_stage
	output	reg	[36:0]		pipeline_reg_out,	//	[36:21],16bits:	miff.mem_access_addr[15:0]
												//	[20:5],16bits:	miff.mem_read_data[15:0]
												//	[4:0],5bits:	write_back_en, write_back_dest[2:0], write_back_result_mux, 
	output		[2:0]		mem_op_dest
);
	
	assign miff.mem_access_addr = pipeline_reg_in[37:22];
	assign miff.mem_write_en = pipeline_reg_in[21];
	assign miff.mem_write_data = pipeline_reg_in[20:5];	
	
	/********************** Data memory *********************/
	// a ram
	//Instance of Interface
	mem_if miff(clk);
	//Dmem Instance and connection to IF
	data_mem dmem(miff);
	/********************** singals to WB_stage *********************/
	always @ (posedge clk) begin
		if(rst) begin
			pipeline_reg_out[36:0] <= 0;
		end
		else begin
			pipeline_reg_out[36:21] <= miff.mem_access_addr;
			pipeline_reg_out[20:5]	<= miff.mem_read_data ;
			pipeline_reg_out[4:0] 	<= pipeline_reg_in[4:0];
		end
	end
	
	
	/********************** to hazard detection unit *********************/
	assign mem_op_dest = pipeline_reg_in[3:1];

endmodule 
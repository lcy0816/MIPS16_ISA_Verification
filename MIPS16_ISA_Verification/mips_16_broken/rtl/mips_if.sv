interface mem_if (input wire clk);
	logic	[15:0]			mem_access_addr;
	
	// write port
	logic	[15:0]			mem_write_data;
	logic					mem_write_en;
	// read port
	logic	[15:0]			mem_read_data;

	modport memory (input clk, input mem_access_addr,input mem_write_data,input mem_write_en,output mem_read_data);
	modport cpu (input clk, output mem_access_addr,output mem_write_data,output mem_write_en,input mem_read_data);

endinterface
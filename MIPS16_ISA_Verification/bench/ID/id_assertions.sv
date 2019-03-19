`include "mips_16_defs.v"

program id_assertions(
    input                   clk,
    input                   rst,
    input                   instruction_decode_en,
    //input                 insert_bubble,
    
    
    // to EX_stage
    input   reg [56:0]      pipeline_reg_out,   //  [56:22],35bits: ex_alu_cmd[2:0], ex_alu_src1[15:0], ex_alu_src2[15:0]
                                                //  [21:5],17bits:  mem_write_en, mem_write_data[15:0]
                                                //  [4:0],5bits:    write_back_en, write_back_dest[2:0], write_back_result_mux, 
    
    // to IF_stage
    input       [15:0]      instruction,
    input       [15:0]      instruction_reg,
    input       [3:0]       ir_op_code_with_bubble,
    input       [5:0]       branch_offset_imm,
    input   reg             branch_taken,
    
    // to register file
    input       [2:0]       reg_read_addr_1,    // register file read port 1 address
    input       [2:0]       reg_read_addr_2,    // register file read port 2 address
    input       [15:0]      reg_read_data_1,    // register file read port 1 data
    input       [15:0]      reg_read_data_2,    // register file read port 2 data
    
    // to hazard detection unit
    input       [2:0]       decoding_op_src1,       //source_1 register number
    input       [2:0]       decoding_op_src2,        //source_2 register number
    input       [2:0]       ir_dest_with_bubble,
    input                   write_back_en,
    input                   write_back_result_mux,
    input       [2:0]       ex_alu_cmd,
    input                   alu_src2_mux
);
    
    
    property id_stall;
        @(posedge clk) disable iff( rst )
            !instruction_decode_en |=> $stable(instruction_reg);
    endproperty
    assert property (id_stall) else
    begin
        $error("ID STALL ASSERTION FAILS");
        $display("************* instruction_reg is %h and past instruction_reg is %h",pipeline_reg_out, $past(pipeline_reg_out));
    end
    id_stall_c: cover property (id_stall);

    property id_op_stall;
        @(posedge clk) disable iff( rst )
            !instruction_decode_en |-> (ir_op_code_with_bubble === 0);
    endproperty        
    assert property (id_op_stall) else
    begin
        $error("ID OP STALL ASSERTION FAILS");
        $display("************* instruction is %b ",ir_op_code_with_bubble);
    end
    id_op_stall_c: cover property (id_op_stall);

    property id_dest_stall;
        @(posedge clk) disable iff( rst )
            !instruction_decode_en |-> ir_dest_with_bubble ==? 3'b000;
    endproperty        
    assert property (id_dest_stall) else
    begin
        $error("ID DEST STALL ASSERTION FAILS");
        $display("************* instruction is %h ",ir_dest_with_bubble);
    end
    id_dest_stall_c: cover property (id_dest_stall);

    property P_OP_NOP;
        @(posedge clk) disable iff( rst )
            (ir_op_code_with_bubble === 4'b0000) |-> ( write_back_en == 0 && write_back_result_mux === 1'bx && ex_alu_cmd === 3'bxxx    && alu_src2_mux === 1'bx);
    endproperty        
    assert property (P_OP_NOP) else
    begin
        $error("ASSERTION FAILS");
        $display("************* instruction OP_NOP is %h ",write_back_en);
    end
    P_OP_NOP_c: cover property (P_OP_NOP);

    property P_OP_ADD;
        @(posedge clk) disable iff( rst )
            (ir_op_code_with_bubble == 4'b0001 ) |-> ( (write_back_en ==? 1'b1) && (write_back_result_mux ==? 1'b0) && (ex_alu_cmd ==? 3'b000 )  && (alu_src2_mux ==? 1'b0) );            
    endproperty        
    assert property (P_OP_ADD) else
    begin
        $error("ASSERTION FAILS");
        $display("************* instruction OP_ADD is %h WR EN %h WR MUX %h CMD %h  SRC2 MUX%h ",ir_op_code_with_bubble, write_back_en, write_back_result_mux, ex_alu_cmd, alu_src2_mux);
    end
    P_OP_ADD_c: cover property (P_OP_ADD);

    property P_OP_SUB;
        @(posedge clk) disable iff( rst )
            (ir_op_code_with_bubble === 4'b0010) |-> ( write_back_en == 1'b1 && write_back_result_mux === 1'b0    && ex_alu_cmd === 3'b001  && alu_src2_mux === 0);            
    endproperty        
    assert property (P_OP_SUB) else
    begin
        $error("ASSERTION FAILS");
        $display("************* instruction OP_SUB is %h ",write_back_en);
    end
    P_OP_SUB_c: cover property (P_OP_SUB);

    property P_OP_AND;
        @(posedge clk) disable iff( rst )
            (ir_op_code_with_bubble === 4'b0011) |-> ( write_back_en == 1 && write_back_result_mux === 0    && ex_alu_cmd === 3'b010  && alu_src2_mux === 0);            
    endproperty        
    assert property (P_OP_AND) else
    begin
        $error("ASSERTION FAILS");
        $display("************* instruction OP_AND is %h ",write_back_en);
    end
    P_OP_AND_c: cover property (P_OP_AND);

    property P_OP_OR;
        @(posedge clk) disable iff( rst )
            (ir_op_code_with_bubble === 4'b0100)  |-> ( write_back_en == 1 && write_back_result_mux === 0    && ex_alu_cmd === 3'b011  && alu_src2_mux === 0);            
    endproperty        
    assert property (P_OP_OR) else
    begin
        $error("ASSERTION FAILS");
        $display("************* instruction OP_OR is %h ",write_back_en);
    end
    P_OP_OR_c: cover property (P_OP_OR);

    property P_OP_XOR;
        @(posedge clk) disable iff( rst )
            (ir_op_code_with_bubble === 4'b0101) |-> ( write_back_en == 1 && write_back_result_mux === 0    && ex_alu_cmd === 3'b100  && alu_src2_mux === 1'bx);            
    endproperty        
    assert property (P_OP_XOR) else
    begin
        $error("ASSERTION FAILS");
        $display("************* instruction OP_XOR is %h ",write_back_en);
    end
    P_OP_XOR_c: cover property (P_OP_XOR);

    property P_OP_SL;
        @(posedge clk) disable iff( rst )
            (ir_op_code_with_bubble === 4'b0110)  |-> ( write_back_en == 1 && write_back_result_mux === 0    && ex_alu_cmd === 3'b101   && alu_src2_mux === 0);            
    endproperty        
    assert property (P_OP_SL) else
    begin
        $error("ASSERTION FAILS");
        $display("************* instruction OP_SL is %h ",write_back_en);
    end
    P_OP_SL_c: cover property (P_OP_SL);

    property P_OP_SR;
        @(posedge clk) disable iff( rst )
            (ir_op_code_with_bubble === 4'b0111)  |-> ( write_back_en == 1 && write_back_result_mux === 0    && ex_alu_cmd === 3'b110   && alu_src2_mux === 0);            
    endproperty        
    assert property (P_OP_SR) else
    begin
        $error("ASSERTION FAILS");
        $display("************* instruction OP_SR is %h ",write_back_en);
    end
    P_OP_SR_c: cover property (P_OP_SR);

    property P_OP_SRU;
        @(posedge clk) disable iff( rst )
            (ir_op_code_with_bubble === 4'b1000) |-> ( write_back_en == 1 && write_back_result_mux === 0    && ex_alu_cmd === 3'b111  && alu_src2_mux === 0);            
    endproperty        
    assert property (P_OP_SRU) else
    begin
        $error("ASSERTION FAILS");
        $display("************* instruction OP_SRU is %h ",write_back_en);
    end
    P_OP_SRU_c: cover property (P_OP_SRU);

    property P_OP_ADDI;
        @(posedge clk) disable iff( rst )
            (ir_op_code_with_bubble === 4'b1001)|-> ( write_back_en == 1 && write_back_result_mux === 0    && ex_alu_cmd === 3'b000  && alu_src2_mux === 1);            
    endproperty        
    assert property (P_OP_ADDI) else
    begin
        $error("ASSERTION FAILS");
        $display("************* instruction OP_ADDI is %h ",write_back_en);
    end
    P_OP_ADDI_c: cover property (P_OP_ADDI);

    property P_OP_LD;
        @(posedge clk) disable iff( rst )
            (ir_op_code_with_bubble === 4'b1010)  |-> ( write_back_en == 1 && write_back_result_mux === 1    && ex_alu_cmd === 3'b000  && alu_src2_mux === 1);            
    endproperty        
    assert property (P_OP_LD) else
    begin
        $error("ASSERTION FAILS");
        $display("************* instruction OP_LD is %h ",write_back_en);
    end
    P_OP_LD_c: cover property (P_OP_LD);

    property P_OP_ST;
        @(posedge clk) disable iff( rst )
            (ir_op_code_with_bubble === 4'b1011)  |-> ( write_back_en == 0 && write_back_result_mux === 1'bx && ex_alu_cmd === 3'b000  && alu_src2_mux === 1);            
    endproperty        
    assert property (P_OP_ST) else
    begin
        $error("ASSERTION FAILS");
        $display("************* instruction OP_ST is %h ",write_back_en);
    end
    P_OP_ST_c: cover property (P_OP_ST);

    property P_OP_BZ;
        @(posedge clk) disable iff( rst )
            (ir_op_code_with_bubble === 4'b1100)  |-> ( write_back_en == 0 && write_back_result_mux === 1'bx && ex_alu_cmd === 3'bxxx   && alu_src2_mux === 1);
    endproperty        
    assert property (P_OP_BZ) else
    begin
        $error("ASSERTION FAILS");
        $display("************* instruction OP_BZ is %h ",instruction);
    end
    id_wb_mux_c: cover property (P_OP_BZ);

endprogram
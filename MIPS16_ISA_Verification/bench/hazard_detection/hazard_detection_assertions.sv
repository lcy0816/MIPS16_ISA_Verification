program hazard_detection_assertions(
    input               clk,
    input               rst,
    input       [2:0]   decoding_op_src1,       //ID stage source_1 register number
    input       [2:0]   decoding_op_src2,       //ID stage source_2 register number    
    input       [2:0]   ex_op_dest,             //EX stage destinaton register number
    input       [2:0]   mem_op_dest,            //MEM stage destinaton register number
    input       [2:0]   wb_op_dest,             //WB stage destinaton register number    
    input               pipeline_stall_n        // Active low

);

    property stall_length;
        @(posedge clk) disable iff( rst )
            !pipeline_stall_n |-> !pipeline_stall_n[*1:3] ##1 pipeline_stall_n;
    endproperty
    assert property (stall_length);
    stall_length_c: cover property (stall_length);
    

    sequence src1;
        (decoding_op_src1 != 0) and ((decoding_op_src1 == ex_op_dest) or (decoding_op_src1 == mem_op_dest) or (decoding_op_src1 == wb_op_dest));
    endsequence

    sequence src2;
        (decoding_op_src2 != 0) and ((decoding_op_src2 == ex_op_dest) or (decoding_op_src2 == mem_op_dest) or (decoding_op_src2 == wb_op_dest));
    endsequence

    property stall_operation;
        @(posedge clk) disable iff( rst )
            (src1 or src2) |-> !pipeline_stall_n;
    endproperty
    assert property (stall_operation);
    stall_operation_c: cover property (stall_operation);

    property stall_operation_backwards;
        @(posedge clk) disable iff( rst )
            !pipeline_stall_n |-> (src1 or src2);
    endproperty
    assert property (stall_operation_backwards);
    stall_operation_backwards_c: cover property (stall_operation_backwards);


endprogram
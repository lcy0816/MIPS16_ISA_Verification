program EX_assertions
(
    input                   clk,
    input                   rst,
    // from ID_stage
    input       [56:0]      pipeline_reg_in,    //  [56:22],35bits: ex_alu_cmd[2:0], ex_alu_src1[15:0], ex_alu_src2[15:0]
                                                //  [21:5],17bits:  mem_write_en, mem_write_data[15:0]
                                                //  [4:0],5bits:    write_back_en, write_back_dest[2:0], write_back_result_mux, 
    
    // to MEM_stage
    input       [37:0]      pipeline_reg_out,   //  [37:22],16bits: ex_alu_result[15:0];
                                                //  [21:5],17bits:  mem_write_en, mem_write_data[15:0]
                                                //  [4:0],5bits:    write_back_en, write_back_dest[2:0], write_back_result_mux, 
    
    // to hazard detection unit
    input       [2:0]       ex_op_dest
);


    wire    [2:0]       alu_cmd         = pipeline_reg_in[56:54];               
    wire    [15:0]      alu_src1        = pipeline_reg_in[53:38];
    wire    [15:0]      alu_src2        = pipeline_reg_in[37:22];
    wire    [15:0]      ex_alu_result   = pipeline_reg_out[37:22] ;
    

                        
    property check_add;
        @(posedge clk) disable iff(rst)
            ( alu_cmd === 3'b000 )|=> (ex_alu_result === $past(alu_src1) + $past(alu_src2));
    endproperty    
    assert property (check_add)
    else
    begin 
        $error("**************UNSUCCESSFUL ADDITION**************");   
        $display("ALU COMD %d, RESULT %d, PAST SRC1 %d, PAST SRC2 %d", alu_cmd, ex_alu_result, $past(alu_src1), $past(alu_src2) );
    end
    check_add_c: cover property (check_add);
        
    
    property check_sub;
        @(posedge clk) disable iff(rst)
            ( alu_cmd === 3'b001 )|=> (ex_alu_result === $past(alu_src1) - $past(alu_src2));
    endproperty        
    assert property (check_sub)
    else $error("**************UNSUCCESSFUL SUBTRACTION**************");
    check_sub_c: cover property (check_sub);
        
        
    property check_and;
        @(posedge clk) disable iff(rst)
            ( alu_cmd === 3'b010 )|=> (ex_alu_result === ($past(alu_src1) & $past(alu_src2)) );
        endproperty
    assert property (check_and) else
    begin 
        $error("**************UNSUCCESSFUL AND**************");   
        $display("ALU COMD %d, RESULT %b, PAST SRC1 %b, PAST SRC2 %b", alu_cmd, ex_alu_result, $past(alu_src1), $past(alu_src2) );
    end
    check_and_c: cover property (check_and);
        
        
        
    property check_or;
        @(posedge clk) disable iff(rst)
            ( alu_cmd === 3'b011 )|=> (ex_alu_result === ($past(alu_src1) | $past(alu_src2))  );
        endproperty        
    assert property (check_or)
    else $error("**************UNSUCCESSFUL OR**************");
    check_or_c: cover property (check_or);
        
        
    property check_xor;
        @(posedge clk) disable iff(rst)
            ( alu_cmd === 3'b100 ) |=> (ex_alu_result === ($past(alu_src1) ^ $past(alu_src2))  );
    endproperty    
    assert property (check_xor) else
    begin 
        $error("**************UNSUCCESSFUL XOR**************");   
        $display("ALU COMD %d, RESULT %d, PAST SRC1 %d, PAST SRC2 %d", alu_cmd, ex_alu_result, $past(alu_src1), $past(alu_src2) );
    end
    check_xor_c: cover property (check_xor);
        
        
    property check_sl;
        @(posedge clk) disable iff(rst)
             (alu_cmd === 3'b101 )|=> (ex_alu_result === {{16{$past(alu_src1[15])}},$past(alu_src1)} << $past(alu_src2));
    endproperty
    assert property (check_sl)
    else $error("**************UNSUCCESSFUL SHIFT LEFT OPERATION************");
    check_sl_c: cover property (check_sl);

        
    property check_sr;
        @(posedge clk) disable iff(rst)
            ( alu_cmd === 3'b110 )|=> (ex_alu_result === {{16{$past(alu_src1[15])}},$past(alu_src1)} >> $past(alu_src2));
    endproperty   
    assert property (check_sr)
    else
    begin
        $error("**************UNSUCCESSFUL SHIFT RIGHT OPERATION************");  
        $display("ALU CMD %h ALU RESULT %d EXPECTED %d ", $past(alu_cmd), ex_alu_result, {{16{$past(alu_src1[15])}},$past(alu_src1)} >> $past(alu_src2) );
    end
    check_sr_c: cover property (check_sr);  


    property check_sru;
        @(posedge clk) disable iff(rst)
            ( alu_cmd === 3'b111 )|=> (ex_alu_result === {16'b0, $past(alu_src1)} >> $past(alu_src2));
    endproperty        
    assert property (check_sru)
    else $error("**************UNSUCCESSFUL SHIFT RIGHT UNSIGNED OPERATION************");     
    check_sru_c: cover property (check_sru);                      
                            
    
 endprogram:EX_assertions

                

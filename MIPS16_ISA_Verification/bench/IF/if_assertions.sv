`include "mips_16_defs.v"

program if_assertions(
    input                           clk,
    input                           rst,                //active high
    input                           instruction_fetch_en,
    
    input   [5:0]                   branch_offset_imm,
    input                           branch_taken,
    
    input  reg [8-1:0]      pc,
    input  [15:0]                   instruction
);
    
    
    property pc_increment;
        @(posedge clk) disable iff( rst )
            !branch_taken && instruction_fetch_en |=> pc ==? $past(pc) + 8'h1;
     endproperty
    assert property (pc_increment) else
    begin
        $error("PC INCREMENT ASSERTION FAILS");
        $display("************* pc is %h and past pc is %h",pc, $past(pc));
    end
    pc_increment_c: cover property (pc_increment);

    property pc_stall;
        @(posedge clk) disable iff( rst )
            !instruction_fetch_en |=> $stable(pc);//changed need to check in the next cycle
    endproperty
    assert property (pc_stall) else
    begin
        $error("PC STALL ASSERTION FAILS");
        $display("************* pc is %h and pc is %h",pc, $past(pc));
    end
    pc_stall_c: cover property (pc_stall);

    property pc_branch;
        @(posedge clk) disable iff( rst )
            branch_taken && instruction_fetch_en |=> (pc == $past(pc) +  {{(8-6){$past(branch_offset_imm[5])}}, $past(branch_offset_imm[5:0])} );
     endproperty
    assert property (pc_branch) else
    begin
        $error("PC BRANCH ASSERTION FAILS");
        $display("************* pc is %d PAST PC IS %d and pc should be %d PAST IMM %d, PAST BRANCH TAKEN %h",pc, $past(pc), $past(pc) +  {{(8-6){$past(branch_offset_imm[5])}}, $past(branch_offset_imm[5:0])}, {{(8-6){$past(branch_offset_imm[5])}}, $past(branch_offset_imm[5:0])}, $past(branch_taken)  );
    end
    pc_branch_c: cover property (pc_branch);

endprogram
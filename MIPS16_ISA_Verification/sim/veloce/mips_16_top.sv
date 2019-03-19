`timescale 1ns/1ps

module mips_16_top( input clk, input rst, output wire [7:0] pc);

    //Instances
    mips_16_core_top uut ( .*);

    initial
    begin
        $readmemb("./hazard_detection.prog",mips_16_top.uut.IF_stage_inst.imem.rom);
    end


endmodule
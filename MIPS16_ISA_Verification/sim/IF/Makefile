if:
	vlib work
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../mips_16/rtl/*.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/clock_generator.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/IF/if_top.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/IF/if_top_tb.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/IF/if_assertions.sv
	vsim  -c -coverage -voptargs="+cover=bcest+/if_top/uut" work.if_top -do "toggle add -full sim:/if_top/uut/*; run -all;  coverage report -instance /if_top/uut; fcover report -r /if_top/uut/*; quit" 
if_gui:
	vlib work
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../mips_16/rtl/*.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/clock_generator.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/IF/if_top.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/IF/if_top_tb.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/IF/if_assertions.sv
	vsim  -coverage -voptargs="+cover=bcest+/if_top/uut" work.if_top -do "toggle add -full sim:/if_top/uut/*; run -all;  coverage report -instance /if_top/uut; fcover report -r /if_top/uut/*; quit" 
if_broken:
	vlib work
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../mips_16_broken/rtl/*.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/clock_generator.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/IF/if_top.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/IF/if_top_tb.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/IF/if_assertions.sv
	vsim  -c -coverage -voptargs="+cover=bcest+/if_top/uut" work.if_top -do "toggle add -full sim:/if_top/uut/*; run -all;  coverage report -instance /if_top/uut; fcover report -r /if_top/uut/*; quit" 

clean:
	rm -rf transcript work/  

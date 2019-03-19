ex_stage:
	vlib work
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../mips_16/rtl/*.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/clock_generator.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/EX/EX_stage_top.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/EX/Ex_stage_top_tb.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/EX/EX_assertions.sv
	vsim  -c -coverage -voptargs="+cover=bcest+/EX_stage_top_top/uut" work.EX_stage_top -do "toggle add -full sim:/EX_stage_top/uut/*; run -all;  coverage report -instance /EX_stage_top/uut; fcover report -r /EX_stage_top/uut/*; quit" 
ex_stage_gui:
	vlib work
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../mips_16/rtl/*.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/clock_generator.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/EX/EX_stage_top.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/EX/Ex_stage_top_tb.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/EX/EX_assertions.sv
	vsim  -novopt -coverage -voptargs="+cover=bcest+/EX_stage_top/uut" work.EX_stage_top -do "toggle add -full sim:/EX_stage_top/uut/*; run -all;  coverage report -instance /EX_stage_top/uut; fcover report -r /EX_stage_top/uut/*; quit" 
ex_stage_broken:
	vlib work
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../mips_16_broken/rtl/*.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/clock_generator.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/EX/EX_stage_top.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/EX/Ex_stage_top_tb.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/EX/EX_assertions.sv
	vsim  -c -coverage -voptargs="+cover=bcest+/EX_stage_top_top/uut" work.EX_stage_top -do "toggle add -full sim:/EX_stage_top/uut/*; run -all;  coverage report -instance /EX_stage_top/uut; fcover report -r /EX_stage_top/uut/*; quit" 
clean:
	rm -rf transcript work/  

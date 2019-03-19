top:
	sh assembly.sh
	vlib work
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../mips_16/rtl/*.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/clock_generator.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/top/reg_saver.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/top/mips_16_top.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/top/mips_16_top_tb.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/hazard_detection/hazard_detection_assertions.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/register_file/register_file_assertions.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/MEM/mem_assertions.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/WB/wb_assertions.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/IF/if_assertions.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/EX/EX_assertions.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/ID/id_assertions.sv
	vsim  -c -gSAVE_REGS=1 -novopt -coverage -voptargs="+cover=bcest+/mips_16_top/uut" work.mips_16_top -do "toggle add -full sim:/mips_16_top/uut/*; run -all; coverage report -instance /mips_16_top/uut;coverage report -instance /mips_16_top/uut/*; fcover report -r /mips_16_top/uut/*;quit" 
top_gui:
	sh assembly.sh
	vlib work
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../mips_16/rtl/*.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/clock_generator.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/top/reg_saver.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/top/mips_16_top.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/top/mips_16_top_tb.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/hazard_detection/hazard_detection_assertions.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/register_file/register_file_assertions.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/MEM/mem_assertions.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/WB/wb_assertions.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/IF/if_assertions.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/EX/EX_assertions.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/ID/id_assertions.sv
	vsim  -gSAVE_REGS=1 -novopt -coverage -voptargs="+cover=bcest+/mips_16_top/uut" work.mips_16_top -do "toggle add -full sim:/mips_16_top/uut/*; run -all; coverage report -instance /mips_16_top/uut;coverage report -instance /mips_16_top/uut/*; fcover report -r /mips_16_top/uut/*;" 
	#vsim  work.mips_16_top -gSAVE_REGS=1 -novopt 
top_broken:
	sh assembly.sh
	vlib work
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../mips_16_broken/rtl/*.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/clock_generator.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/top/reg_saver.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/top/mips_16_top.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/top/mips_16_top_tb.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/hazard_detection/hazard_detection_assertions.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/register_file/register_file_assertions.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/MEM/mem_assertions.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/WB/wb_assertions.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/IF/if_assertions.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/EX/EX_assertions.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/ID/id_assertions.sv
	vsim  -c -gSAVE_REGS=0 -novopt -coverage -voptargs="+cover=bcest+/mips_16_top/uut" work.mips_16_top -do "toggle add -full sim:/mips_16_top/uut/*; run -all; coverage report -instance /mips_16_top/uut;coverage report -instance /mips_16_top/uut/*; fcover report -r /mips_16_top/uut/*;quit" 
clean:
	rm -rf transcript work/  
	rm ../../bench/top/testcases/*.prog
	rm ../../results/saved_regs/*

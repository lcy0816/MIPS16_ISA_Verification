wb:
	vlib work
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../mips_16/rtl/*.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/clock_generator.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/WB/wb_top.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/WB/wb_top_tb.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/WB/wb_assertions.sv
	vsim  -c -coverage -voptargs="+cover=bcest+/wb_top/uut" work.wb_top -do "toggle add -full sim:/wb_top/uut/*; run -all;  coverage report -instance /wb_top/uut; fcover report -r /wb_top/uut/*; quit" 
wb_gui:
	vlib work
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../mips_16/rtl/*.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/clock_generator.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/WB/wb_top.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/WB/wb_top_tb.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/WB/wb_assertions.sv
	vsim  -novopt -coverage -voptargs="+cover=bcest+/wb_top/uut" work.wb_top -do "toggle add -full sim:/wb_top/uut/*; run -all;  coverage report -instance /wb_top/uut; fcover report -r /wb_top/uut/*; quit" 
wb_broken:
	vlib work
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../mips_16_broken/rtl/*.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/clock_generator.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/WB/wb_top.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/WB/wb_top_tb.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/WB/wb_assertions.sv
	vsim  -c -coverage -voptargs="+cover=bcest+/wb_top/uut" work.wb_top -do "toggle add -full sim:/wb_top/uut/*; run -all;  coverage report -instance /wb_top/uut; fcover report -r /wb_top/uut/*; quit" 
clean:
	rm -rf transcript work/  

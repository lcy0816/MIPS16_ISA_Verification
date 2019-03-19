mem:
	vlib work
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../mips_16/rtl/*.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/clock_generator.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/MEM/mem_top.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/MEM/mem_top_tb.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/MEM/mem_assertions.sv
	vsim  -c -coverage -voptargs="+cover=bcest+/mem_top/uut" work.mem_top -do "toggle add -full sim:/mem_top/uut/*; run -all;  coverage report -instance /mem_top/uut; fcover report -r /mem_top/uut/*; quit" 
mem_gui:
	vlib work
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../mips_16/rtl/*.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/clock_generator.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/MEM/mem_top.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/MEM/mem_top_tb.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/MEM/mem_assertions.sv
	vsim  -coverage -voptargs="+cover=bcest+/mem_top/uut" work.mem_top -do "toggle add -full sim:/mem_top/uut/*; run -all;  coverage report -instance /mem_top/uut; fcover report -r /mem_top/uut/*; quit" 
mem_broken:
	vlib work
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../mips_16_broken/rtl/*.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/clock_generator.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/MEM/mem_top.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/MEM/mem_top_tb.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/MEM/mem_assertions.sv
	vsim  -c -coverage -voptargs="+cover=bcest+/mem_top/uut" work.mem_top -do "toggle add -full sim:/mem_top/uut/*; run -all;  coverage report -instance /mem_top/uut; fcover report -r /mem_top/uut/*; quit" 
clean:
	rm -rf transcript work/  

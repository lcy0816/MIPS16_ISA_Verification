id:
	vlib work
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../mips_16/rtl/*.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/clock_generator.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/ID/id_top.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/ID/id_top_tb.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/ID/id_assertions.sv
	vsim  -c -coverage -voptargs="+cover=bcest+/id_top/uut" work.id_top -do "toggle add -full sim:/id_top/uut/*; run -all;  coverage report -instance /id_top/uut; fcover report -r /id_top/uut/*; quit" 
id_gui:
	vlib work
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../mips_16/rtl/*.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/clock_generator.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/ID/id_top.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/ID/id_top_tb.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/ID/id_assertions.sv
	vsim  -coverage -novopt -voptargs="+cover=bcest+/id_top/uut" work.id_top -do "toggle add -full sim:/id_top/uut/*; run -all;  coverage report -instance /id_top/uut; fcover report -r /id_top/uut/*; quit" 
id_broken:
	vlib work
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../mips_16_broken/rtl/*.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/clock_generator.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/ID/id_top.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/ID/id_top_tb.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/ID/id_assertions.sv
	vsim  -c -coverage -voptargs="+cover=bcest+/id_top/uut" work.id_top -do "toggle add -full sim:/id_top/uut/*; run -all;  coverage report -instance /id_top/uut; fcover report -r /id_top/uut/*; quit" 

clean:
	rm -rf transcript work/  

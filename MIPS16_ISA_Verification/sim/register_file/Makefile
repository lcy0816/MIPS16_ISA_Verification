register_file:
	vlib work
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../mips_16/rtl/*.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/clock_generator.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/register_file/register_file_top.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/register_file/register_file_top_tb.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/register_file/register_file_assertions.sv
	vsim  -c -coverage -voptargs="+cover=bcest+/register_file_top/uut" work.register_file_top -do "toggle add -full sim:/register_file_top/uut/*; run -all;  coverage report -instance /register_file_top/uut; fcover report -r /register_file_top/uut/*; quit" 
register_file_gui:
	vlib work
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../mips_16/rtl/*.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/clock_generator.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/register_file/register_file_top.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/register_file/register_file_top_tb.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/register_file/register_file_assertions.sv
	vsim  -coverage -voptargs="+cover=bcest+/register_file_top/uut" work.register_file_top -do "toggle add -full sim:/register_file_top/uut/*; run -all; coverage report -instance /register_file_top/uut; fcover report -r /register_file_top/uut/*; quit" 
register_file_broken:
	vlib work
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../mips_16_broken/rtl/*.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/clock_generator.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/register_file/register_file_top.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/register_file/register_file_top_tb.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/register_file/register_file_assertions.sv
	vsim  -c -coverage -voptargs="+cover=bcest+/register_file_top/uut" work.register_file_top -do "toggle add -full sim:/register_file_top/uut/*; run -all;  coverage report -instance /register_file_top/uut; fcover report -r /register_file_top/uut/*; quit" 
clean:
	rm -rf transcript work/  

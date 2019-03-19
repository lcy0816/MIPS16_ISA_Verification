hazard_detection:
	vlib work
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../mips_16/rtl/*.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/clock_generator.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/hazard_detection/hazard_detection_top.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/hazard_detection/hazard_detection_top_tb.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/hazard_detection/hazard_detection_assertions.sv
	vsim  -c -coverage -voptargs="+cover=bcest+/hazard_detection_top/uut" work.hazard_detection_top -do "toggle add -full sim:/hazard_detection_top/uut/*; run -all;  coverage report -instance /hazard_detection_top/uut; fcover report -r /hazard_detection_top/uut/*; quit" 
hazard_detection_gui:
	vlib work
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../mips_16/rtl/*.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/clock_generator.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/hazard_detection/hazard_detection_top.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/hazard_detection/hazard_detection_top_tb.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/hazard_detection/hazard_detection_assertions.sv
	vsim  -coverage -voptargs="+cover=bcest+/hazard_detection_top/uut" work.hazard_detection_top -do "toggle add -full sim:/hazard_detection_top/uut/*; run -all;  coverage report -instance /hazard_detection_top/uut; fcover report -r /hazard_detection_top/uut/*; quit" 
hazard_detection_broken:
	vlib work
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../mips_16_broken/rtl/*.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/clock_generator.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/hazard_detection/hazard_detection_top.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/hazard_detection/hazard_detection_top_tb.sv
	vlog  +incdir+../../mips_16/rtl -cover bcest ../../bench/hazard_detection/hazard_detection_assertions.sv
	vsim  -c -coverage -voptargs="+cover=bcest+/hazard_detection_top/uut" work.hazard_detection_top -do "toggle add -full sim:/hazard_detection_top/uut/*; run -all;  coverage report -instance /hazard_detection_top/uut; fcover report -r /hazard_detection_top/uut/*; quit" 
clean:
	rm -rf transcript work/  

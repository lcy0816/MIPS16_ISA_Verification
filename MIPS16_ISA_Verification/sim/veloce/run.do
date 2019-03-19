configure -emul velocesolo1
reg setvalue mips_16_top.rst 1
run 10
reg setvalue mips_16_top.rst 0
run 60000
upload -tracedir ./veloce.wave/wave1
exit
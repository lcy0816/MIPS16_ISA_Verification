;ASSUMING memory depth SIZE TO BE 256


ADDI R1,R0,1
ADDI R2,R0,1
ADDI R3,R0,8
SL R1,R1,R3
	
LOOP: SUB R1,R1,R2
	  ST  R2,R1,0
	  LD  R2,R1,0
	  BZ  R1,EXIT
	  NOP
	  NOP
	  NOP
	  NOP
	  BZ  R0,LOOP
	  NOP
	  NOP
	  NOP
	  NOP
EXIT:
	NOP
	NOP
	NOP
	NOP
	ADDI R4, R0, 4
	LD	R5,R0,0
	NOP
	NOP
	NOP
	NOP
	NOP
	

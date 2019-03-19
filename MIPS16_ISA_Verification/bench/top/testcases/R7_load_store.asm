;ASSUMING memory depth SIZE TO BE 256
ADDI R2,R0,1
ADDI R7,R0,1
ADDI R3,R0,8
SL R2,R2,R3
	
LOOP: SUB R2,R2,R7
	  ST  R7,R2,0
	  LD  R7,R2,0
	  BZ  R2,EXIT
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
	

;ASSUMING memory depth SIZE TO BE 256
ADDI R2,R0,1
ADDI R4,R0,1
ADDI R3,R0,8
SL R2,R2,R3
	
LOOP: SUB R2,R2,R4
	  ST  R4,R2,0
	  LD  R4,R2,0
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
	ADDI R1, R0, 4
	LD	R5,R0,0
	NOP
	NOP
	NOP
	NOP
	NOP
	

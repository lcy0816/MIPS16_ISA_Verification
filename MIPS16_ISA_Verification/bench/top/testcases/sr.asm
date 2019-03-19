;Test cases for the Logical Shift Right operation
	ADDI   R1, R0, 3   
	ADDI   R2, R0, 5   
    SR     R3, R1, R2   
    SR     R1, R2, R1  
    SR     R2, R3, R1  
	SR     R3, R3, R2  
    SR     R4, R2, R3  
	ADDI   R4, R0, 6   
	ADDI   R5, R0, 4   
	SR     R5, R4, R3  
	SR     R6, R5, R4  
	SR     R7, R6, R2 
	ADDI   R3, R0, 1
	ADDI   R4, R0, 14
	SL     R3, R3, R4
	SR	   R3, R3, R4
	NOP
	NOP
	NOP
	NOP
	NOP

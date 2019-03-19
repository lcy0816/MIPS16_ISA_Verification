;Test cases for the Subtraction operation
   	ADDI   R1, R0, 7  
	ADDI   R2, R0, 1 
        SUB    R1, R1, R2 
        SUB    R2, R1, R0
	ADDI   R3, R0, 9  
	ADDI   R4, R0, 5 
	SUB    R5, R3, R2 
        SUB    R3, R2, R5
        SUB    R4, R4, R0 
        SUB    R5, R4, R5 
        SUB    R6, R1, R5 
        SUB    R7, R4, R6 
	SUB    R2, R5, R7 
	SUB    R0, R6, R7 


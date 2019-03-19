;Test cases for Logical Shift Left operation
	ADDI   R1, R0, 3   
	ADDI   R2, R0, 5   
        SL     R3, R1, R2   
        SL     R1, R2, R1  
        SL     R2, R3, R1  
	SL     R3, R3, R2  
        SL     R4, R2, R3  
	ADDI   R4, R0, 6   
	ADDI   R5, R0, 4   
	SL     R5, R4, R3  
	SL     R6, R5, R4  
	SL     R7, R6, R2 

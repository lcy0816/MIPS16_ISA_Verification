;Test cases for or operation
	ADDI   R1, R0, 3   
	ADDI   R2, R0, 5     
        OR    R3, R1, R2   
        OR    R1, R2, R1  
        OR    R2, R3, R1  
	OR    R3, R3, R2  
        OR    R4, R2, R3  
	ADDI   R4, R0, 6  
	ADDI   R5, R0, 4  
	OR    R5, R4, R3  
	OR    R6, R5, R4  
	OR    R7, R6, R2  

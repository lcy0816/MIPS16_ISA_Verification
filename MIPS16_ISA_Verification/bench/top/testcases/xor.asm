;Test cases to test the or operation
	ADDI   R1, R0, 3  
	ADDI   R2, R0, 5 
        XOR    R3, R1, R2  
        XOR    R1, R2, R1  
        XOR    R2, R3, R1  
	XOR    R3, R3, R2 
        XOR    R4, R2, R3  
	ADDI   R4, R0, 6   
	ADDI   R5, R0, 4   
	XOR    R5, R4, R3  
	XOR    R6, R5, R4  
	XOR    R7, R6, R2  

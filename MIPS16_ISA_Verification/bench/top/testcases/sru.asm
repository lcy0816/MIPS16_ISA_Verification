;Test cases for the Usigned Shift right operation
	ADDI    R1, R0, 3   
	ADDI    R2, R0, 5   
        SRU     R3, R1, R2   
        SRU     R1, R2, R1  
        SRU     R2, R3, R1  
	SRU     R3, R3, R2  
        SRU     R4, R2, R3  
	ADDI    R4, R0, 6   
	ADDI    R5, R0, 4   
	SRU     R5, R4, R3  
	SRU     R6, R5, R4  
	SRU     R7, R6, R2 

;Test cases for the AND operation
;each register tested as a destination
;each register also tested as a source 
;register R0 is a special type of register 
;which can have a value written to it whenn it is used as a 
;destination operand but when used as a source
;it always has the value 0 in it
	ADDI   R1, R0, 3   
	ADDI   R2, R0, 5     
    AND    R3, R1, R2   
    AND    R1, R2, R1  
    AND    R2, R3, R1  
	AND    R3, R3, R2  
    AND    R4, R2, R3  
	ADDI   R4, R0, 6   
	ADDI   R5, R0, 4   
	AND    R5, R4, R3  
	AND    R6, R5, R4 
	AND    R7, R6, R2  

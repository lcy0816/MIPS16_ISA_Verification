;Hazard detection unit test
;The hazard detection unit compares if the source operand of the
;current instruction is equal to the destination operand of the 
;3 previous instructions
;Test both source operands
;Test 3 stages of previous operations
;Test boundaries
;What happens if the source operand is $R0

;load values
ADDI R1, R0, 12
ADDI R2, R0, 3
ADDI R5, R0, 2
;1) Source1 
;a)1 previous instruction
ADDI R3, R0, 2	;source 1 is R3 
ADDI R4, R3, 1	
;b)2 previous instructions
ADDI R1, R0, 4  ;source 1 is R1
NOP
SUB  R2, R1, R2 ;try using same operand
;c)3 previous instrucions
OR   R4, R3, R0 ;source 1 is R4, try using R0
SL	 R1, R1, R3 ;try R1 boundary (4 previous instruction)
AND  R3, R5, R3
XOR  R4, R4, R2 ;try R2 boundary (4 previous instruction)
;2) Source2
;a)1 previous instruction
SR   R2, R5, R5  ;source 2 is R2
ADD  R1, R5, R2
;b)2 previous instruction
ADD  R5, R3, R3 ;source 2 is R5
SUB  R4, R4, R3 ;try R4 boundary (4 previous instruction)
ADD  R2, R2, R5
;c)3 previous instruction
XOR  R3, R3, R1 ;source 2 is R3
NOP
NOP
OR   R4, R4, R3 
NOP
NOP
NOP
NOP
NOP
NOP
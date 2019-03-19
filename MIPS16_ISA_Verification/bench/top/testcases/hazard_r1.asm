;load values
;1)Source 1
;a)1 previous instructions
ADDI R1, R0, 3 ;source 1 is R1
ADDI R2, R1, 1
;b)2 previous instructions
NOP
NOP
NOP
ADDI R1, R0, 1
NOP
ADD  R3, R1, R2
;c)3 previous instructions
NOP
NOP
NOP
ADDI R1, R0, 1
NOP
NOP
ADD  R4, R1, R2
;2)Source 2
;a)1 previous instruction
NOP
NOP
NOP
ADDI R1, R0, 2 ;source 2 is R1
ADD  R5, R2, R1
;b)2 previous instruction
NOP
NOP
NOP
ADDI R1, R0, 2
NOP
ADD R6, R2, R1
;c) 3 previous instructions
NOP
NOP
NOP
ADDI R1, R0, 3
NOP
NOP
ADD R7, R2, R1
NOP
NOP
NOP
NOP
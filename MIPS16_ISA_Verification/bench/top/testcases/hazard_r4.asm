;load values
;1)Source 1
;a)1 previous instructions
ADDI R4, R0, 3 ;source 1 is R4
ADDI R1, R4, 1
;b)2 previous instructions
NOP
NOP
NOP
ADDI R4, R0, 1
NOP
ADD  R2, R4, R1
;c)3 previous instructions
NOP
NOP
NOP
ADDI R4, R0, 1
NOP
NOP
ADD  R3, R4, R1
;2)Source 2
;a)1 previous instruction
NOP
NOP
NOP
ADDI R4, R0, 2 ;source 2 is R1
ADD  R5, R1, R4
;b)2 previous instruction
NOP
NOP
NOP
ADDI R4, R0, 2
NOP
ADD R6, R1, R4
;c) 3 previous instructions
NOP
NOP
NOP
ADDI R4, R0, 3
NOP
NOP
ADD R7, R1, R4
NOP
NOP
NOP
NOP
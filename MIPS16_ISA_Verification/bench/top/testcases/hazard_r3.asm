;load values
;1)Source 1
;a)1 previous instructions
ADDI R3, R0, 3 ;source 1 is R3
ADDI R1, R3, 1
;b)2 previous instructions
NOP
NOP
NOP
ADDI R3, R0, 1
NOP
ADD  R2, R3, R1
;c)3 previous instructions
NOP
NOP
NOP
ADDI R3, R0, 1
NOP
NOP
ADD  R4, R3, R1
;2)Source 2
;a)1 previous instruction
NOP
NOP
NOP
ADDI R3, R0, 2 ;source 2 is R1
ADD  R5, R1, R3
;b)2 previous instruction
NOP
NOP
NOP
ADDI R3, R0, 2
NOP
ADD R6, R1, R3
;c) 3 previous instructions
NOP
NOP
NOP
ADDI R3, R0, 3
NOP
NOP
ADD R7, R1, R3
NOP
NOP
NOP
NOP
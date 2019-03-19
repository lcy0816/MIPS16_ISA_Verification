;load values
;1)Source 1
;a)1 previous instructions
ADDI R0, R0, 3 ;source 1 is R0
ADDI R1, R0, 3
;b)2 previous instructions
NOP
NOP
NOP
ADDI R0, R0, 2 
NOP
ADD  R0, R0, R1
;c)3 previous instructions
NOP
NOP
NOP
ADDI R0, R0, 2 
NOP
NOP
ADD  R0, R0, R1
;2)Source 2
;a)1 previous instruction
NOP
NOP
NOP
ADDI R0, R0, 1 ;source 2 is R0
ADD  R0, R1, R0
;b)2 previous instruction
NOP
NOP
NOP
ADDI R0, R0, 2
NOP
ADD R1, R1, R0
;c) 3 previous instructions
NOP
NOP
NOP
ADDI R0, R0, 3
NOP
NOP
ADD R1, R1, R0
NOP
NOP
NOP
NOP
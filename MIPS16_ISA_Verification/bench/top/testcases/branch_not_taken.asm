;not taken loop many times to get R3 1
ADDI R2,R0,8
ADDI R1,R0,1
    
LOOP: SUB R2,R2,R1
      BZ  R2,EXIT
      NOP
      NOP
      NOP
      NOP
      ADDI R3,R0,1
      NOP
      NOP
      NOP
      NOP
      BZ  R0,LOOP
      NOP
      NOP
      NOP
      NOP
EXIT:
    NOP
    NOP
    NOP
    NOP
    ADDI R7, R0, 1
    NOP
    NOP
    NOP
    NOP
    NOP
    

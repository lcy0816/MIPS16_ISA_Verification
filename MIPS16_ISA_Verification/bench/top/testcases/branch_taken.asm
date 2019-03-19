;branch taken, no loop will be excuted, to get R3 0
ADDI R2,R0,8
ADDI R1,R0,8
    
LOOP: SUB R2,R2,R1
      BZ  R2,EXIT
      NOP
      NOP
L1:   NOP //JUMPS TO HERE
      NOP
      ADDI R3,R0,1
      NOP
      NOP
      NOP
      BZ  R0,FINAL
      NOP
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
    BZ R0, L1
    NOP
    NOP
    NOP
    NOP
FINAL:
    NOP
    ADDI R6, R0, 1
    NOP
    NOP
    NOP
    NOP
    NOP

;Assembly code to test the ADD operation.
;each register tested as a destination
;each register also tested as a source 
;register R0 is a special type of register 
;which can have a value written to it whenn it is used as a 
;destination operand but when used as a source
;it always has the value 0 in it

	ADDI R0, R0, 7	;Value 7 loaded into R0
	ADDI R1, R0, 1  ;1 added to R0 which makes R1 1
    ADDI R2, R1, 2  ;3 added to R1 making R2 3
    ADD  R1, R0, R2 ;R1=R0+R2=10
    ADDI R4, R2, 4  ;R4=R2+4=7
    ADDI R5, R3, 2  ;R5=R3+2=2
    ADD  R1, R4, R5 ;R1=R4+R5=9
    ADD  R2, R5, R3 ;R2=R5+R3=2
	ADD  R3, R1, R5 ;R3=R1+R5=9
	ADD  R4, R3, R2 ;R4=R2+R3=13
	ADD  R5, R1, R2 ;R5=R1+R2=11
	ADD  R6, R5, R3 ;R6=R5+R3=22
	ADD  R7, R2, R6 ;R7=R2+R6=24

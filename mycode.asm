
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

DAC0832 EQU 88H 
M8255_A EQU 80H
M8255_B EQU 82H
M8255_C EQU 84H
M8255_Z EQU 86H
TIME    DW  00H

START: MOV DX,M8255_Z
       MOV AL,81H  ;SET 8086
       OUT DX,AL
 STEP: ;CALL CLEAN
       CALL PMW
       JMP  STEP
;CLEAN PROGRAM
    CLEAN PROC NEAR
        MOV DX,M8255_B
        MOV AL,00H
        OUT DX,AL
        RET
    CLEAN ENDP

;PMWPROGRAM
PMW PROC BEAR
    FB: MOV DX,DAC0832
        MOV AL,0
        OUT DX,AL
        LOOP FB
        MOV CX,TIME  ;CHANGE LOW
   FB1: MOV DX,M8255_C
        MOV AL,03H
        OUT DX,AL 
        IN  AL,M8255_C
        CMP AL,02H
        JZ FB2
        CMP AL,01H
        JZ FB3
        MOV AL,0FFH
        MOV DX,88H
        OUT DX,AL
        LOOP FB1
        MOV CX,2FH
        JMP PMW
    FB2: CALL DELAY
         ADD TIME,0002H
         JMP  FB1
    FB3: CALL DELAY
         SUB TIME,0002H
         JMP  FB1
PMW  ENDP         
DELAY PROC NEAR
    PUSH CX
    MOV CX,00FFH
D1:
    MOV AX,00FFH
D2:
    DEC AX
    JNZ D2
   LOOP D1
   POP  CX
   RET 
DELAY ENDP





Name Order

DATA SEGMENT
Array DB 76H, 30H, 54H, 20H, 10H
ALEN  = ($ - Array) / TYPE Array
DATA ENDS

;-------------------������-------------------
MAIN SEGMENT
     ASSUME CS: MAIN, DS: DATA
START: MOV  CX, ALEN
       LEA  SI, Array
       CALL FAR PTR Bobble
       
       HLT
MAIN ENDS
;--------------------------------------------

;------------------������------------------
ORDER SEGMENT
     ASSUME CS:ORDER, DS:DATA, ES: DATA

;-----------------ð������-------------------
;��Array�еĵ�������ð������
;���: CX�����鳤�ȣ���SI������������ָ�룩
;����: SI������������ָ��)
Bobble PROC FAR

            PUSH BX
            PUSH AX
            PUSH DX
            PUSHF
            MOV  DX, 0
            MOV  BX, CX
            DEC  BX
            PUSH BX

BCMP:       MOV  AL, [SI + BX]
            SUB  BX, TYPE Array
            CMP  AL, BYTE PTR [SI + BX]
            JB   EXCHANGE

NEXT:       CMP  BX, DX
            JA   BCMP
            JMP  AGAIN

EXCHANGE:   XCHG AL, [SI + BX]
            MOV  [SI + BX + TYPE Array], AL
            MOV  AH, 255
            JMP  NEXT

AGAIN:      INC  DX
            POP  BX
            PUSH BX
            CMP  AH, 1
            JZ   FINISH
            MOV  AH, 1
            LOOP BCMP

FINISH:     ADD  SP, 2
            POPF
            POP  DX
            POP  AX
            POP  BX
            
            RET
Bobble ENDP

ORDER ENDS
;--------------------------------------------
      END START
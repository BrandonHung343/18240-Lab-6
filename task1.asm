     .ORG $1500
A    .DW $1 ; A 
B    .DW $80 ; B

     .ORG $1000
     LW R1, R0, A ; load in A
     LW R2, R0, B ; load in B
     LI R3, $0 ; clear register 3 for input
     SLLI R5, R3, $7 ; 8 bits, shift 7 for sign. 
     MV R4, R2 ; put B in R4
     MV R7, R1 ; put A in R7
     BRZ mult ; If 0, sign was 0 so we can multiply
     NOT R4, R2; flip every bit in B, store in R4
     ADDI R4, R4, $1 ; add 1 to not B, R4 = abs(B)
mult LI R6, $1 ; get LSB of abs(B) 
     AND R0, R4, R6 ; see if lsb = 1
     BRZ next
     ADD R3, R3, R1 ; Add a copy of A to C
next SRLI R4, R4, $1 ; Shift abs(B) one right
     SLLI R7, R7, $1 ; Shift A one left
     SLTI R0, R4, $0 ; check if abs(B) = 0
     BRZ done ; if it is 0, the we are done
     BRA mult ; go back to next loop step
done SLTI R0, R5, $0; check what the sign is
     BRZ fin
     NOT R3, R3 ; negate 
     ADDI R3, R3, $1 ; add 1 for 2s comp
fin  STOP ; done 
     
     
     
     
     

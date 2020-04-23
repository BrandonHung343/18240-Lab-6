     .ORG $1500
A    .DW $7 ; A 
B    .DW $64 ; B

     .ORG $1000
     LW R1, R0, A ; load in A
     LW R2, R0, B ; load in B
     LI R3, $0 ; clear register 3 for input
     MV R4, R2 ; put B in R4
     MV R7, R1 ; put A in R7 
     SRLI R5, R2, $7 ; 8 bits, shift 7 for sign. 
     BRZ chkA ; If 0, sign was 0 so we can multiply
     NOT R4, R2; flip every bit in B, store in R4
     ADDI R4, R4, $1 ; add 1 to not B, R4 = abs(B)
chkA SRLI R5, R1, $7 ; check if A is negative
     BRZ init ; not negative so good to go
     NOT R7, R1 ; 2s compl
     ADDI R7, R7, $1 ;
     LI R5, $FF ; 0 out the top 8 bits
     AND R7, R7, R5 ; 8 bit representation of our number
init LI R5, $0 ; initialize our counter
mult LI R6, $1 ; get LSB of abs(B) 
     AND R0, R4, R6 ; see if lsb = 1
     BRZ next
     ADD R3, R3, R7 ; Add a copy of A to C
next SRLI R4, R4, $1 ; Shift abs(B) one right
     SLLI R7, R7, $1 ; Shift A one left
     ADDI R5, R5, $1 ; increment counter by 1
     SLTI R0, R5, $8 ; check if shifted by 8 yet
     BRZ done ; if it is 0, the we are done
     BRA mult ; go back to next loop step
done SRLI R5, R2, $7 ; 8 bits, shift 7 for sign. 
     BRZ finA ; if 0, good, is positive
     NOT R3, R3 ; negate 
     ADDI R3, R3, $1 ; add 1 for 2s comp
finA SRLI R5, R1, $7 ; 8 bits, shift 7 for sign. 
     BRZ iAm
     NOT R3, R3 ; negate 
     ADDI R3, R3, $1 ; add 1 for 2s comp
iAm  SLTI R0, R2, $80 ; check if first is int min
     BRZ iBm
     BRA fin
iBm  SLTI R0, R1, $80 ; first was int min, what about second?
     BRA fin
flip NOT R3, R3 ; negate 
     ADDI R3, R3, $1 ; add 1 for 2s comp
fin  STOP ; done

     
     
     
     
     

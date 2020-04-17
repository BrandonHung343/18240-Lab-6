     .ORG $106
X    .DW $80 ; A
Y    .DW $0 


     .ORG $200
P1   LW R1, R0, X ; load in x
     LW R2, R0, X ; load in x
     LI R3, $0 ; clear register 3 for input
     MV R4, R2 ; put B in R4
     MV R7, R1 ; put A in R7 
     SRLI R5, R2, $7 ; 8 bits, shift 7 for sign. 
     BRZ chkA1 ; If 0, sign was 0 so we can multiply
     NOT R4, R2; flip every bit in B, store in R4
     ADDI R4, R4, $1 ; add 1 to not B, R4 = abs(B)
chkA1 SRLI R5, R1, $7 ; check if A is negative
     BRZ init1 ; not negative so good to go
     NOT R7, R1 ; 2s compl
     ADDI R7, R7, $1 ;
     LI R5, $FF ; 0 out the top 8 bits
     AND R7, R7, R5 ; 8 bit representation of our number
init1 LI R5, $0 ; initialize our counter
mult1 LI R6, $1 ; get LSB of abs(B) 
     AND R0, R4, R6 ; see if lsb = 1
     BRZ next1
     ADD R3, R3, R7 ; Add a copy of A to C
next1 SRLI R4, R4, $1 ; Shift abs(B) one right
     SLLI R7, R7, $1 ; Shift A one left
     ADDI R5, R5, $1 ; increment counter by 1
     SLTI R0, R5, $8 ; check if shifted by 8 yet
     BRZ done1 ; if it is 0, the we are done
     BRA mult1 ; go back to next loop step
done1 SRLI R5, R2, $7 ; 8 bits, shift 7 for sign. 
     BRZ finA1 ; if 0, good, is positive
     NOT R3, R3 ; negate 
     ADDI R3, R3, $1 ; add 1 for 2s comp
finA1 SRLI R5, R1, $7 ; 8 bits, shift 7 for sign. 
     BRZ fin1 ; finish
     NOT R3, R3 ; negate 
     ADDI R3, R3, $1 ; add 1 for 2s comp
fin1 SW R3, R0, $104 ; store x^2 at $104
     LI R5, $7 ; load 7 into r5
     SW R5, R0, $102 ; store 7 in 102
     SW R3, R0, $100 ; store x^2 at 100
     BRA P2; done

     .ORG $250
P2   LW R1, R0, $100 ; load in x^2
     LW R2, R0, $102 ; load in 7
     LI R3, $0 ; clear register 3 for input
     MV R4, R2 ; put B in R4
     MV R7, R1 ; put A in R7 
     SRLI R5, R2, $7 ; 8 bits, shift 7 for sign. 
     BRZ chkA2 ; If 0, sign was 0 so we can multiply
     NOT R4, R2; flip every bit in B, store in R4
     ADDI R4, R4, $1 ; add 1 to not B, R4 = abs(B)
chkA2 SRLI R5, R1, $7 ; check if A is negative
     BRZ init2 ; not negative so good to go
     NOT R7, R1 ; 2s compl
     ADDI R7, R7, $1 ;
     LI R5, $FF ; 0 out the top 8 bits
     AND R7, R7, R5 ; 8 bit representation of our number
init2 LI R5, $0 ; initialize our counter
mult2 LI R6, $1 ; get LSB of abs(B) 
     AND R0, R4, R6 ; see if lsb = 1
     BRZ next2
     ADD R3, R3, R7 ; Add a copy of A to C
next2 SRLI R4, R4, $1 ; Shift abs(B) one right
     SLLI R7, R7, $1 ; Shift A one left
     ADDI R5, R5, $1 ; increment counter by 1
     SLTI R0, R5, $8 ; check if shifted by 8 yet
     BRZ done2 ; if it is 0, the we are done
     BRA mult2 ; go back to next loop step
done2 SRLI R5, R2, $7 ; 8 bits, shift 7 for sign. 
     BRZ finA2 ; if 0, good, is positive
     NOT R3, R3 ; negate 
     ADDI R3, R3, $1 ; add 1 for 2s comp
finA2 SRLI R5, R1, $7 ; 8 bits, shift 7 for sign. 
     BRZ fin2
     NOT R3, R3 ; negate 
     ADDI R3, R3, $1 ; add 1 for 2s comp
fin2 SW R3, R0, $100 ; store 7x^2 at $100
     LI R5, $64 ; store -28 at 102
     SW R5, R0, $102 ; store -28 at 102
     BRA P3 ; done

     .ORG $300
P3   LW R1, R0, X ; load in X
     LW R2, R0, $102 ; load in -28
     LI R3, $0 ; clear register 3 for input
     MV R4, R2 ; put B in R4
     MV R7, R1 ; put A in R7 
     SRLI R5, R2, $7 ; 8 bits, shift 7 for sign. 
     BRZ chkA3 ; If 0, sign was 0 so we can multiply
     NOT R4, R2; flip every bit in B, store in R4
     ADDI R4, R4, $1 ; add 1 to not B, R4 = abs(B)
chkA3 SRLI R5, R1, $7 ; check if A is negative
     BRZ init3 ; not negative so good to go
     NOT R7, R1 ; 2s compl
     ADDI R7, R7, $1 ;
     LI R5, $FF ; 0 out the top 8 bits
     AND R7, R7, R5 ; 8 bit representation of our number
init3 LI R5, $0 ; initialize our counter
mult3 LI R6, $1 ; get LSB of abs(B) 
     AND R0, R4, R6 ; see if lsb = 1
     BRZ next3
     ADD R3, R3, R7 ; Add a copy of A to C
next3 SRLI R4, R4, $1 ; Shift abs(B) one right
     SLLI R7, R7, $1 ; Shift A one left
     ADDI R5, R5, $1 ; increment counter by 1
     SLTI R0, R5, $8 ; check if shifted by 8 yet
     BRZ done3 ; if it is 0, the we are done
     BRA mult3 ; go back to next loop step
done3 SRLI R5, R2, $7 ; 8 bits, shift 7 for sign. 
     BRZ finA3 ; if 0, good, is positive
     NOT R3, R3 ; negate 
     ADDI R3, R3, $1 ; add 1 for 2s comp
finA3 SRLI R5, R1, $7 ; 8 bits, shift 7 for sign. 
     BRZ fin3
     NOT R3, R3 ; negate 
     ADDI R3, R3, $1 ; add 1 for 2s comp
fin3 LW R7, R0, $100 ; load in 7x^2
     ADD R7, R7, R3 ; 7x^2 + (-28 x)
     LI R1, $2 ; subtract the two
     SUB R7, R7, R1 ; 7x^2 - 28x - 2;
     SW R7, R0, Y ; store at Y
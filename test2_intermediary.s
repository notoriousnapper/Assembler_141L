//=====================Presets======================//
// r0 and r1 hold outer and inner loop pointers, respectively
// r3 holds anded byte
// r4 holds # of shifts
// r5 will hold byte to be shifted
// r6 holds accumulated values as "temp"

// i0 will hold the 4 bit for comparison
// i1 will hold 5 for keeping track of shifts
// i2 will hold 15 for bitmasking, but requires a mov_ie
// i3 will be everything, but also used to grab 9 --

//====PRESET i0 = Four_Bit_Match_String ===//
mov_imm 9
mov_ei r2, i3       // Grab 4 bits
ld     r2, r2
mov_ei r3, i0       // Grab 0, initially in i0
add    r3, r2       // Ensure that first 4 bits are 0 too
mov_ie r3, i0

//====PRESET r0=32, r1=64 ===/
mov_imm 16
mov_ei  r0, i3
shf     r0, 0, 1
mov     r0, r1
shf     r1, 0, 1

//====PRESET i1=5 ===/
mov_imm 5
mov_ei  r2, i3
mov_ie  r2, i1   // Set i1 as 5

//====PRESET i2 = 00001111 for Mask ==========//
mov_imm 15
mov_ei  r2, i3
mov_ie  r2, i2

//=========== OUTER: ===================/
ld   r5, r0
cmp  r0, r1
bne  r7, 0, 1      // JUMP to OUTER_END if 32 reaches 64

//=========== INNER: ===================/
mov_imm 31     // 47  //} START_CALC
mov_ei  r7, i3
mov_imm 15
mov_ei  r2, i3
add     r7, r2
cmp_int r4, i1    //} END_CALC
bne     r7, 0, 1  // Jumps to INNER_END to move to outer iteration

//========== SHIFTING & BITMASKING =========== //
// 5 times to check, designate r3 as temp
                //===BITMASK====//
                mov    r5, r3
                and    r3, r2  // Get last 4 bits

                mov_imm 31
                mov_ei  r7, i3
                mov_imm 7
                mov_ei  r2, i3
                add     r7, r2

                cmp_int r3, i0     //==Match?
                bne    r7, 0, 0    //If Not Match==JUMP to SKIP ADD &34

                mov_imm 1
                mov_ei  r3, i3
                add     r6, r3     // Update Max

                //==SKIP ADD:==/
                shf  r5, 0, 0    // Shift Byte Right
                mov_imm 1
                mov_ei  r3, i3
                add     r4, r3   // Increment shift #

                mov_imm 20
                mov_ei  r7, i3
                ba      r7, 0, 0 // JUMP TO INNER & 22

//=========== INNER_END: ===================//

//=== UPDATE HISTOGRAM ==== //

mov_imm 9
mov_ei  r7, i3
add     r7, r2  // get address 9 + matched freq (count)
mov     r7, r2
ld      r7, r2  // Load original value into r7

mov_imm 1
mov_ei  r3, i3
add     r7, r3
st      r7, r2  // Store incremented value back in 

//=== SKIP HISTOGRAM UPDATE ==== //
// Reset r6
mov_imm 0
mov_ei  r6, i3  // Reset temp


mov_imm 1
mov_ei  r2, i3
add     r0, r2    // Increment Ptr#1

mov_imm 17
mov_ei  r7, i3
ba      r7, 0, 0  // JUMP to OUTER

//========== TBD:  CORRECT THIS, should store into histogram ===/
mov_imm  8
mov_ei   r1, i3
st       r6, r1

//=========== OUTER_END: ===================//

halt  // Literally just end

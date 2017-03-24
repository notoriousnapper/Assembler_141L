//=====================Presets======================//
// r0 and r1 hold outer and inner loop pointers, respectively
// r3 holds anded byte
// r4 holds # of shifts
// r5 will hold byte to be shifted
// r6 holds accumulated values as "temp"

// i0 will hold the 4 bit for comparison
// i1 will hold 5 for keeping track of shifts
// i2 will hold 15 for bitmasking, but requires a mov_ie


//====PRESET i1=5 ===/
mov_imm 5
mov_ei  r2, i3
mov_ie  r2, i1   // Set i1 as 5


//====PRESET i1 = Four_Bit_Match_String ===//
mov_imm 9
mov_ei r7, i3       // Grab 4 bits
mov_ei r2, i0       // Grab 0
add    r7, r2       // Ensure that first 4 bits are 0 too
mov_ie r7, i0


//====PRESET i2 = r2 ==========//
mov_imm 15
mov_ei  r2, i3
mov_ie  r2, i2






mov_ie r2, i2   // 1111
mov_imm 0       // Reset counter to know if 5 shifts have been done
mov_ei  r4, i3
mov_ei  r6, i3  // Reset temp variable for incrementing matches
ld      r5, r0  // Get byte to compare

//=========== INNER: ===================/
cmp_int r4, i1
bne     r7, 0, 1  // Jumps to INNER_END to move to outer iteration

//========== SHIFTING & BITMASKING =========== //
// 5 times to check, designate r3 as temp

                //===BITMASK====//
                mov    r5, r3
                and    r3, r2 // Get last 4 bits
                cmp_int r3, i0 // Compare
                mov_int
                bne    r7, 0, 1

                mov_imm 1
                mov_ei  r3, i3
                add     r6, r3

                //==SKIP ADD:==/
                add     r4, r3   // Increment shift #
                ba      r7, 0, 0 // JUMP TO INNER LABEL

//=========== INNER_END: ===================//

// Update value
mov_imm 1
mov_ei r2, i3
add    r0, r2   // Increment Outer Loop

halt



//========Random Useless Stuff ======/

// Create 255 for a
mov_imm 15
mov_ei  r2, i3
shf     r2, 1, 1
mov_imm 15
mov_ei  r3, i3
add     r3, r2 // Holds 255
mov     r3, r2

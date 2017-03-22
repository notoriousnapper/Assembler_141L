// Internal Reg
// i1 - Counter 1
// i2 - Counter 2
// i3 - Accumulator 1 is the result of movi mov_int
// i4 - Always holds 0.  Like %g0 in spark  ---> should be i0 honestly.

// r2 - Stores the 64 Value
// r3 - Reusable used for storing calculated address to store as temp
// r4 - Stores 5 Constant
// r5 - Stores the 4-bit string
// r6 -




// Q18 Algorithm --> Histogram of frequency for XORs
// 

// Steps to add 1 without compromising a different add instruction format.
  load_inc r1 r2      //  Doubles as an "add 1 instruction" to first register
                       // %R1 has garbage value in this context

//  Notes:
//  1. Main reason we have a movi instruction is because
//  there are two many circumstances where we need a mov with an immediate value
//  and a register.  the movi & mov_int combo solves that problem for now
//  2. We Re-ruse a lot of registers before they are finally set
//     Example we use R1 early in the initialization stage knowing
//     it will be overwritten in the loop.  This way
//     we still follow our R-Type rule of first operand = 2bit and second = 3bit

  movi     9        // moves to %i3 register
  mov_int  i3 r5
  load_inc r2 r5      // Load First Byte into R5
  movi     15
  mov_int  i3 r3
  and      r3 r5      // Get 4-bit "String" by anding

  movi     2        // Big mov always moves into internal register 3
  mov_int  i3 r6      //
  shf      r2 1 1    // Stores 32 after shifting

  movi     4
  mov_int  i3 r2      // Stores 64 Constant
  shf      r2 1 1     // Make it 64 by shifting it left 4

  movi    5
  mov_int  i3 r4      // Stores 5 Constant

  mov      r3 r6      // Have to copy to follow R-Type rule holds 32 // OUTER:
  load_inc r3 r7      // lds in one byte and increments address
  mov_int  i0 r7    // Reset Tally

  mov      r1 r3   // Have to copy to follow R-Type rule             // INNER:
  and      r3 r7   // BitMask to get 4LSB
  cmp      r3 r7
  bne      2
  add      r1 r7    //  Increment tally

  shf       r7 0 0       //  Shifts current Byte to check next match      // SKIP:
  inc               // Increment inner loop counter

  cmp_int  i1 r4   // ^All this to check if ctr2 == 5
  bne      -9

  //# Store Tallied Frequency
  movi     9
  mov_int i3 r3


  add      r2 r3      // Holds calculated address



  load_inc r3 r7       // Re-use tally reg for a bit
  add      r1 r2
  st       r2 r3
  mov_int  i3 r7     // Reset tally to 0

  //####
  inc
  cmp_int  i0 r2        // Outer loop stops at 64
  bne  20             // Should be negative, will change to branching by register amounts
                      // Step - move immediate value, branch by that.  Need to move more immediate valeus though
                      // Main idea = Use only 8 instructions, 3 x 3 instructions and also more immediate values to use

//END:

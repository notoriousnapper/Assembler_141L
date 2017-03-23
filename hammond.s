
		//TEST MODULE -- HAMMOND DISTANCE CHECK & LOAD

    ///////////// BEGIN GET LSB  /////////////
                // Get 16 //
    mov_ei r3, i0        // Set as 0
    mov_imm 16
    mov_ei  r7, i3
    mov_ei  r5, i3         // 16
    //shf     r7, 1, 1     // Get 16 in here

                ===Get 175===
    mov_imm 10
    mov_ei  r2, i3
    shf     r2, 1, 1     // 175
    mov_imm 15
    mov_ei  r1, i3
    add     r2, r1

    /////////////// XOR TO SETUP ////////////////
    xor     r5, r2



    //////////////  BIT ITERATION LABEL /////
    //TBD
    mov_imm 25
    mov_ei  r7, i3
    cmp_int r5, i0  // BIT_ITERATION:  //  Jump to END *V*
    bne r7,  0, 1   //be  END:: // skip

    ///////////// GET LSB ////////////////
    mov_imm 1
    mov_ei  r7, i3				// For Anding, set r7 as 1
    mov     r5, r2					// Mov from r5 into r2   // Safety Move
    and 		r7, r2 					// Get LSB
    mov     r7, r2					// Mov from r7 into r2   // Safety Move
    add 		r3, r2					// Accumulator for Temp **
    shf			r5, 0, 0				// Shift Right by 1

    mov_imm 11
    mov_ei r7, i3
    ba r7,  0, 0   // TBD:   BIT ITERATION  //
    ///////////// END GET LSB ////////////////
    halt

    //END://

    //BRANCHING CHECK
    // Make sure r2 value is rained after
    //mov_imm 5
    //mov_ei  r2, i3

    //mov_imm 16 // Branching generated logic Starting @ this line
    //mov_ei r7, i3
    //shf r7, 0, 1
    //shf r7, 0, 1
    //mov_ie r2, i2
    //mov_imm 31
    //mov_ei r2, i3
    //add r7, r2
    //mov_imm 2
    //mov_ei r2, i3
    //add r7, r2
    //mov_ei r2, i2
    //// Should have  97 in r7
    //bne r7,  0, 0

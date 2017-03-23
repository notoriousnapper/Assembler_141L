//////////// Presets /////////////
// Hammond Algorithm
// XOR 2 Bytes, see if there's a difference
// ex) 10010000 and 00100000 should be 3
// ex) 00000000 and 00000000 should be 0

mov_imm 8
mov_ei   r0, i3

shf     r0, 1, 1
mov 		r0, r1 				  // Ptr #2
mov_imm  18
mov_ei  r7, i3					// 18
mov_imm  19
mov_ei  r2, i3					// 18
add 		r7, r2
shf     r7, 0, 1				// 37 * 2
shf     r7, 0, 1				// 37 * 2
mov_ie 		r7, i2 				// i2 will 148
	// R5 starts at 0
	// START OUTER//

	//====CHECKPOINT 1 END ===/
	cmp_int     r0, i2     			// ===OUTER:====
	//==CALCULATE  BRANCH DISTANCE TO END
	bne         r7, 0, 1 								// Jump to End ProgramEND_OUTER  // End program

	  //############ INNER #################//
		// Comes from bottom
		cmp_int 	r1, i2 //Compare to 148/ / ===INNER:===

		// If reached with end
				//==CALCULATEBRANCH DISTANCE TO END_INNER
		bne     r7, 1, 1     // Jumps to END_INNER
	  ld 			r5, r0       // Loads same r0 into r5 // Might need to optimize placement
		ld 			r6, r1       // Load New Byte To Compare

		//====CHECKPOINT 2 - VALUES ===/

		//==INNERINNER LOOP
		mov     r6, r2					// Ready Outer Byte
		mov_ie  r5, i1					// Ready Inner Byte
		mov_ei  r7, i1
		xor 		r5, r2 					// Result in r5
		mov_ei   r3, i0					// RESET TEMP HAMMOND

		//##########  BEGINNING OF LOWEST LOOP ########
		//Fill in code for bne
		//{-- calculations to 39
		mov_imm 31
		mov_ei r7, i3
		mov_imm 9
		mov_ei r2, i3
		add r7, r2
		//-- endCalculations}
		cmp_int 	r5, i0 					// If 0, continue to next iteration (JUMP TO END_INNER)
		bne			r7, 0, 1        // &SWAP, comparing Temp &40 -- but right at prepping for calcs
													  //With Flag is the same as Branch Equals // Jump to FINISH_CHECK	// Assume r7 holds correct jump address

		//##########  GET LSB ####################
		mov_imm 1
		mov_ei  r7, i3				// For Anding, set r7 as 1
		mov     r5, r2					// Mov from r5 into r2   // Safety Move
		and 		r7, r2 					// Get LSB
		mov     r7, r2					// Mov from r7 into r2   // Safety Move
		add 		r3, r2					// Accumulator for Temp **
		shf			r5, 0, 0				// Shift Right by 1

   //########### FINISH CHECK: LABEL #############
		//add     r1, r2 					     //===FINISH_CHECK:===/
		mov_imm 23
	  mov_ei r7, i3
		ba  		r7, 0, 0				//NEXT LOW LEVEL SHIFT Cycle

		///////////// END GET LSB SHIFTING ////////////////
		///////////// SWAP TEMP WITH MAX IF GREATER //////

		//{-- calculations to
		mov_imm 31
		mov_ei r7, i3
		mov_imm 18
		mov_ei r2, i3
		add r7, r2
		//-- endCalculations}
		cmp r4, r3
		ble r7, 0, 1    //DOWN V// Branch Forward if not greater BGE -- tougher
		mov_ie  r3, i1         // mov r3 to r4 to replace value
		mov_ei  r4, i1         // mov r3 to r4 to replace value
		mov_imm 1
		mov_ei  r3, i3
		add     r1, r3            //INCREMENT INNER POINTER

		mov_imm 14
	  mov_ei r7, i3
		ba  r7, 0, 0							// &15 NEXT INNER LOOP CYCLE, NEXT BYTE
		// Increment OUTER Pointer #1 with 8

		//############### END SWAP ##############################
		//==============END_INNER:======================//

    // Increment OUTER LOOP
		mov_imm 1
		mov_ei r2, i3
		add  r0, r2

		mov_imm 12
		mov_ei r7, i3
		ba  r7, 0, 0

		halt

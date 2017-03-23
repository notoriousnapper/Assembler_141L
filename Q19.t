	//////////// Presets /////////////
	mov_imm 8
	mov_ei   r0, i3

  shf     r0, 1, 1
	mov 		r0, r1 				  // Ptr #2
	mov_imm  18
	mov_ei  r7, i1
  shf     r7, 1, 1

	mov_imm  18
	//mov_ie 		r7, i2 				// i2 will hold 288  // I cant just throw i2 around, I can throw i1 around tho
	//Need a temporary load ---> to compare if i1 is greater than 20.


	  // R5 starts at 0
	  cmp_int     r0, i2     			// ===OUTER:====
		//==CALCULATEBRANCH DISTANCE TO END
	  bne         r7, 0, 1 								// Jump to End ProgramEND_OUTER  // End program
		ld 			    r5, r0       // Loads r0 into r5
	  mov_imm   #(Difference between InnerLoop and END)
	  mov_ei     r7, i3
		  cmp_int 	r1, i2           // ===INNER:===
			// If reached with end
		  		//==CALCULATEBRANCH DISTANCE TO END_INNER
		  bne     r7, 1, 1     // Jumps to END_INNER
			ld 			r6, r1       // Load New Byte To Compare
			mov_ei   r3, i0					// Set Temp = 0

      //==INNERINNER LOOP
			mov     r6, r2					// Ready Outer Byte
			mov_ie  r5, i2					// Ready Inner Byte
			mov_ei  r7, i2
			xor 		r2, r7 					// Result in r5
			cmp_int 	r2, i0 					// If 0, continue to next iteration (JUMP TO END_INNER)

		  		//==CALCULATEBRANCH DISTANCE TO FINISH_CHECK:
		  bne			r7, 0, 1        // With Flag is the same as Branch Equals // Jump to FINISH_CHECK	// Assume r7 holds correct jump address
		  mov_ei  r7, i1				// For Anding, set r7 as 1
			mov     r5, r2					// Mov from r5 into r2   // Safety Move
			and 		r7, r2 					// Get LSB
			mov     r7, r2					// Mov from r7 into r2   // Safety Move
			add 		r3, r2					// Accumulator for Temp **
			shf			r5, 0, 0				// Shift Right by 1


		  add     r1, r2 					     //===FINISH_CHECK:===/
		  		//==CALCULATEBRANCH DISTANCE TO ^INNER

			// TBD:: WHERE TO JUMP BACK UP FOR THINGS
			ba  		r7, 0, 1				//Jumps UP to INNER- goes negative
		  // If TEMP Dist > Max Hammond distance, Add

		  cmp r4, r3    								 //===END_INNER:===/
			    // CALCULATE BRANCH DISTANCE TO FORWARD
		  ble r7, 0, 1			// NOTE FLAG: should be bg  Branch forward to skip add
		  mov_ie  r3, i2         // mov r3 to r4 to replace value
		  mov_ei  r4, i2         // mov r3 to r4 to replace value
		  add     r0, r2 // Increment OUTER Pointer with 8

			//===SKIP_ADD:===/ // End of One Iteration of inner loop --->
			// Increment PTR #2
			mov_imm 8
			mov_ei  r2, i3					// ***
				//CALCULATE JUMP DISTANCE TO TOP
		  // Calculate distance to Top into variable r7
		  ba      r7,   0, 1

	  //  TBD: Get memory address to store in to --> r7
		mov r4, r2 							         //===END_OUTER:===//
	  st      r2, r7
	  halt

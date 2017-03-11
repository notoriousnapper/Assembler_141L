	// //////// Presets /////////////
	//mov_imm #  r8  					// INNERLOOP preset

	// Get
	mov_imm 8
	mov_ei   i3, r0
	mov_ei   i3, r2   			  // r2 holds 8 constant for easy increments

	// Moves
  shf     r0, 1, 1 			  // Shift 4 to multiply by 16, Ptr #1
	mov 		r0, r1 				  // Ptr #2

	mov_imm  18  						// Moves to i2
	mov_ei  r7, i1
  shf     r7, 1, 1 			  // Shift 4 to multiply by 16, Ptr #1
	mov_ie 		r7, i2 				// i2 will hold 288

  OUTER:
	  cmp_int     r5, i2  /////
	  bne       r7 END_OUTER  // End program
		ld 			  r5, r0       // Loads r0 into r5

	  mov_imm   #(Difference between InnerLoop and END)
	  mov_ei     r7, i3

		INNER:
		  cmp_int 	r1, i2       // If reached with end

		  bne     r7, 1, 1     // Jumps to END_INNER
			ld 			r6, r1

			mov_ei   i0, r3					// Set Temp = 0

			mov     r6, r2					// Mov from r6 into r2
			xor 		r5, r2 					// Result in r5
			cmp_int 	r5, i0 					// If 0, branch out


		  bne			r7, 0, 1// FINISH_CHECK							// Assume r7 holds correct jump address

		  mov_ei  r7, 1					// For Anding
					mov     r5, r2					// Mov from r5 into r2   // Safety Move
			and 		r7, r2 					// Get LSB
					mov     r7, r2					// Mov from r7 into r2   // Safety Move
			add 		r3, r2					// If 0, it will add 0
			shf			r5, 0, 0				// Shift Right by 1

		  FINISH_CHECK:
			  add     r1, r2
				ba  		r8, 0, 1				//Jump to INNER- goes negative


		  END_INNER:
		  // If TEMP Dist > Max Hammond distance, Add
		  cmp r4, r3   //

		  ble SKIP_ADD:      // Branch forward to skip add
		  mov r4, r3         // mov r3 to r4 to replace value


		  SKIP_ADD:
		  add     r0, r2          // Increment OUTER Pointer with 8

		  mov_imm  (Whatever number beginning is)
		  mov_ei    r2, i3
		  mov_ei    r7 + r8
		  // Calculate distance to Top into variable r7
		  ba      r7

	  END_OUTER:
	  //  TBD: Get memory address to store in to --> r7
		mov r4, r2
	  st      r2, r7
	  halt

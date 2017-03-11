Constraints/ Things to Check For good assembly
1. 2nd register # doesn't not exceed 3.  ex)    mov r4 r5 != RIGHT
2.







TODO:
1. In README
2. Clever Assembler - For Loops
3. Map out --> External Registers/ Make them E
Constraints -->

// Questions #19
// Find the Hamming Distance - Number of mismatched bits
Initial Presets:
Function Hammon Distance (Takes two registers)

1. XOR two bytes
2. Begin Loop #1
	 	See whole byte = 0, if so, exit and report
	  Else, Is LSB 1?
			If so, increment
		Shift Right
		Dynamic Instruction Count = 8 // Depends on the situation, but is cleaner

		Alternative Loop #2
	 	See whole byte = 0, if so, exit and report
	  Else, Is MSB 1?
			If so, increment
		Shift Right
			Sub A - 1
			And A with (A-1)
		Dynamic Instruction Count = 8 // Depends on the situation, but is cleaner


Algorithm:

Load First Byte from Array from Memory location @ 128
Begin OUTer Loop of Going through each array
Begin INNER Loop of Comparing current byte to each byte in array (N^2 runtime)

  // Load first array with counter @ Address 128
	// Have 2 ptrs, one for inner loop, and one for outer loop, r0 and r1


  // i0 for Holding 0
  // i1 for Holding 1
  // i2 (Free Reg) HOLDS 288 Stores end number for iterations 128 + 160
  // i3 for Compares & mov_imm values

  // r0 for PTR #1
  // r1 for PTR #2
  // r3 for temp Hammon
  // r4 for Hammo
  // r5 for outer byte
  // r6 for inner byte
  // r7 , re-use  // For PTR #1 reuse
  // r8 Holds Inner loop distance

	////////// Presets /////////////
	mov_imm #  r8  					// INNERLOOP preset

	// Get
	mov_imm 8
	mov_ei   i3, r0
	mov_ei   i3, r2   			  // r2 holds 8 constant for easy increments

	// Moves
  shf     r0, 1, 1 			  // Shift 4 to multiply by 16, Ptr #1
	mov 		r0, r1 				  // Ptr #2

	mov_imm  18  						// Moves to i2
	mov_ei   i3, r7
  shf     r7, 1, 1 			  // Shift 4 to multiply by 16, Ptr #1
	mov_ie 		r7, i2 				// i2 will hold 288

  OUTER:
	  cmp_e     r5, i2  /////
	  bne       r7 END_OUTER  // End program
		ld 			  r5, r0       // Loads r0 into r5

	  mov_imm   #(Difference between InnerLoop and END)
	  mov_ei     i3, r7

		INNER:
		  cmp_e 	r1, i2       // If reached with end

		  bne     r7, 1, 1     // Jumps to END_INNER
			ld 			r1, r6

			mov_ei   i0, r3					// Set Temp = 0

			xor 		r5, r6 					// Result in r5
			cmp_e 	r5, i0 					// If 0, branch out


		  bne			r7, 0, 1// FINISH_CHECK							// Assume r7 holds correct jump address

		  mov_ei   i1, r7					// For Anding
			and 		r7, r5 					// Get LSB
			add 		r3, r7					// If 0, it will add 0

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
		  mov_ei    i3, r7
		  mov_ei    r7 + r8
		  // Calculate distance to Top into variable r7
		  ba      r7

	  END_OUTER:
	  //  TBD: Get memory address to store in to --> r7
	  st      r4, r7
	  halt

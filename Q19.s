4:15 - 4:40 | Hammon
4:40 - 5:30 | Draw out ISA more clear/ Understand Control Units// Work on Control Unit Logic
ALU - Testing//

5:30 - 8

5:30 -
CSE 160 ---->//
---     ---->


TODO:
In README
Clever Assembler - For Loops

Map out --> External Registers/ Make them E
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
  // i2 for all purpose   // Stores end number for iterations 128 + 160
  // i3 for Compares & mov int values

  // r0 for PTR #1
  // r1 for PTR #2
  // r3 for temp Hammon
  // r4 for Hammon
  // r5 for outer byte
  // r6 for inner byte
  // r7 , re-use
  // r8 Holds Inner loop distance



	////////// Presets /////////////

	mov_imm #  r8  					// INNERLOOP preset



	// Get
	mov_imm2 8
	mov_e   i2, r0
	mov_e   i2, r2   			  // r2 holds 8 constant for easy increments

	// Moves
	mov_imm  18  							// Moves to i2

  shf     r0, 1, 1 			  // Shift 4 to multiply by 16, Ptr #1
	mov 		r0, r1 				  // Ptr #2

	// If outer loop = last one value (20 bytes).... // Increment by 8... for bytes?
	ld 			r0, r5
	ld 			r1, r6


	/////////  Outer Loops ///////


	/////////  Inner Loops ///////
	INNERLOOP:


  cmp 		r1, r7




	mov_e   i0, r3					// Set Temp = 0

	xor 		r5, r6 					// Result in r5
	cmp_e 	r5, i0 					// If 0, branch out


  bne			r7, 0, 1// FINISH_CHECK							// Assume r7 holds corret jump address

  mov_e   i1, r7					// For Anding
	and 		r5, r7 					// Get LSB
	add 		r7, r3					// If 0, it will add 0

	shf			r5, 0, 0				// Shift Right by 1

	ba  		r8							//INNERLOOP











FINISH_CHECK:
























	ld 			r0, r1				  //




	// i3 = 0
	mov_int_ex i3 r3
	movi 1
  mov_int i3 r1

  movi 14          // Beginning of OUTER:
  cmp i3 r1
	bne 24


  mov_int i0 r4
	load_inc r3 r3 // Fix HW
	mov i3 r5			// copy at outer loop counter
	mov_int i3 r7				// hamming temp distance  *** reset

  mov_int i0 r2
	add r1 r2		// inner loop counter (1 + r1)

  movi 14     // Beginning of INNER:
  cmp i3 r2
	bne 13 // +13
	load_inc r3 r6
	xor r3 r2
  mov r2 r7
	and r2 r7  // r6 should be 1, check
	add r2 r7
	shf r2 0 0
  cmp_int i3 r6
	bne -5
	movi 1
	mov_int i3 r1
	add r1 r2
	ble 12  //  -12 should be neg
	mov r3 r7
	ba 16   // Should be negative, will fix by making registers for ba
  inc    // iNNEr_END:
	ba 28  // Should be negative, will fix

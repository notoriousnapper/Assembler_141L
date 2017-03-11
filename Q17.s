
// internal registers
  // i3 - Accumulator 1 is the result of movi mov_int
  // i0 - Always load_incs 0.  Like g0 in spark

	// r1 = MSB A
	// r2 = LSB A
	// r3 = B
	// r1 = signed bit (0 = positive 1 = negative)
	// r2 = least sig bit of B / temp reg 1
	// r6 = temp reg 2
	// r3 = MSB product
	// r3 = LSB product

	mov_int i0 r3  // Sets to 0
	mov_int i0 r3

  movi    1
	mov_int i3 r2

	load_inc r0 r2			// r1 = MSB A
	load_inc r1 r2			// r2 = LSB A
	load_inc r2 r2			// r3 = MSB B
	load_inc r3 r2			// r1 = LSB B

	shf r2 1 1
	add r3 r2			// move MSB and LSB of B to single register

  movi  8
	mov_int i3 r1
	and r1 r1			// r1 = check signed bit of A
	shf r1 1 1					// align with MSB

	movi 20       // Not currently possible
	mov_int i3 r1      //
	add r1 r1      // Adds 20 + 20
	add r1 r1      // Adds up to 80

	and r3 r1			// r2 = check signed bit of B
	and r3 r1			// r2 = check signed bit of B

	mov r1 r6
	and r2 r6

	cmp_int i3 r6
	bne 4		// if A && B are neg fp is pos

	cmp_int i0 r2
	bne 11


	load_inc r1 r2			// reload_incing r1 because cleared out value


  "Moving in 255" --> Not possible --> currently

  // Trying to get 255 // Check the work
	movi 26       // NEGA:						// if A is neg abs
  mov_int i3 r2
	movi 25       // NEGA:						// if A is neg abs
  mov_int i3 r1
  add r2 r1 // ---> Make sure to make it 3 bits, 2 bits for reg
  add r2 r1
  add r2 r1


	xor r1 r1			// take two's comp: xor by 1's

	movi 1
	mov_int i3 r1
	add r1 r1			// add 1

	cmp_int i0 r6
	bne 3		      //------ NEGAB
	mov i3 r1      // Still is 1
	ba 10      // SCMANTHA? SCHMLONEY?


  // Change here to add up to 255
	movi 15 //------ NEGB:						// if B is neg abs
  mov_int i3 r1
	xor r1 r2			// take two's comp: xor by 1's
	mov_int i3 r1
	add r1 r2			// add 1

  cmp_int i0 r6
	bne 3		// NEGAB
	mov i3 r1
	ba 2

	mov_int i0 r1     // NEGAB:

	mov_int i3  r2     // -----  SMULTiPLY:
	and r3 r2			// r2 = least sig bit of B

  cmp_int i3 r2
	bne 25		      // if LSB == 0 jump

	movi 15
  mov_int i3 r2

	and r3 r2			// ---- FP[r3LSB]
	add r2 r2			// ---- A[LSB] + FP[r3LSB]

  // Why do you need 240!!?
  // Super Clever solution to get large number
	movi 30
  mov_int i3 r2
  shf r2 1 1  // Shift LEft by 4 = times 2^4, gets 240

	and r3 r6			// FP[r3MSB] ----
	shf r6 1 0					// ----	FP[r3MSB]

	mov r2 r3			// move LSB to final product

	mov_int i3 r2

  // Super Clever solution to get large number
	movi 30
  mov_int i3 r2
  shf r2 1 1  // Shift LEft by 4 = times 2^4, gets 240


	and r3 r2			// OV[FP[r3LSB]]
	shf r2 1 0					// ----	OV[FP[r3LSB]]

	add r2 r6			// OV[FP[r3LSB]] + FP[r3MSB]

	mov_int i3 r2  // clear MSB of r3
	and r2 r3			// ----	FB[r3LSB]

	add r1 r6			// ---- A[MSB] + ( OV[FP[r3LSB]] + FP[r3MSB] )

	mov_int i3 r2  // clear MSB of r3
	and r2 r6
	shf r2 1 1					// A[MSB] + ( OV[FP[r3LSB]] + FP[r3MSB] ) ----

	add r2 r3			// FP[r3MSB]	FP[r3LSB]
	shf r6 1 0					// ----	OV[FP[r3MSB]]

	add r2 r3			// OV[FP[r3MSB]] + FP[r3]


  movi 8        // =======  SHiFT:
	mov_int i3 r2
	and r2 r2			// most sig bit of A LSB
	shf r2 0 0
	shf r2 0 0
	shf r2 0 0

	shf r2 0 1					// shfift A left 1
	shf r1 0 1
	add r2 r1			// move bit from LSB A to MSB A

	mov 8
	mov_int i3 r2
	and r2 r1			// clear MSB of MSB A
	and r2 r2			// clear MSB of LSB A

	shf r3 0 0		        // shfift B right 1

  // Way ---> first 3 bits = up to 80, then 2 bits for  up to 4...? OR. -- Since you have
  // Check out another ISA to follow after ----> and make it work
  // MAKE ISA Work + do ----> Freaking extra credit.



	bne -6   // SHOULD BE -63  //    AT ADDRESS 93, calculate correct one later 162-93
	bne 4	   //  SHOULD BE 46  // At 209
	// if signed take two's comp and add 1
  // Mov 255 into r2 // Do shifting later
	mov 25
	mov_int i3 r2
	xor r2 r3			// take two's comp: xor by 1's
	xor r2 r3

	mov 1
	mov_int i3 r2
	movi 15
	mov_int i3 r6

	and r3 r6			// ---- LSB[r3]
	add r2 r6			// ---- LSB[r3]+1

	movi 30
  mov_int i3 r2
  shf r2 1 1  // Shift LEft by 4 = times 2^4, gets 240


	and r3 r2			// MSB[r3] ----
	shf r2 1 0					// ---- MSB[r3]

	mov r3 r6 			// move LSB[r3] + 1 to r3

	movi 30
  mov_int i3 r6
  shf r6 1 1  // Shift LEft by 4 = times 2^4, gets 240


	and r3 r6			// OV[LSB] ----
	shf r6 0 0					// ---- OV[LSB]

	add r2 r2			// OV[LSB] + MSB[r3]

	movi 15       // clear MSB of r3
	mov_int i3 r6
	and r2 r3 			// r3 = ---- LSB[r3]+1

	mov 15       // clear MSB of r3
	mov_int i3 r6
	and r2 r2			// ---- OV[LSB]+MSB[r3]
	shf r2 1 1					// MSB[r3]+OV[LSB] ----

	add r2 r3 			// MSB[r3]+OV[LSB]	LSB[r3]+1

	shf r2 1 0					// ---- OV[MSB]

	add r2 r3			// OV[MSB] + r3

//STOrE:

  mov r3 r1
  mov r3 r2

  movi  5
  mov_int i3 r3
  movi  5
  mov_int i3 r1

	st r1 r3      // Due to constraints of r-Types first operand
  st r2 r1      // Must be 1-4

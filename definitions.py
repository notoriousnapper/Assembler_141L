#Op Codes
def getOp(opCode):
    ohmylord  = { #Thanks Audrey
    'add': 0,
    'and': 1,
    'cmp': 2,
    'mov': 3,
    'mov_ei': 4,
    'ld': 5,
    'st': 6,
    'xor': 7,
    'shf': 8,
    'mov_imm': 9,
    'cmp_int': 10,
    'ba': 11,
    'ble': 12,
    'bne': 13,
    'mov_ie': 14,
    'halt': 15
    }
    return ohmylord[opCode]

# With External Registers & Non-Standard
trickyOpCode = {
 'mov_int': 5,
 'load_inc': 6,
 'movi': 10,
 'cmp_int': 11,
}




# R-type:  _  _  _  _ | _  _ _   |  _  _
#                OP code    reg	       reg
#0000  add			R-Type
#0001  and			R-Type
#0010  cmp			R-Type    Compares two registers
#0011  mov			R-Type
#0100  mov_int	    R-Type
#0101  load_inc	    R-Type
#0110  st 		    R-Type
#0111  xor			R-Type

# I-type:  _  _  _  _ | _  _  _  _  _  (SCRATCH - Same type as J-Type)
#               OP code   Immediate

# H-type:  _  _  _  _ | _  _   |  _  _   _
#                OP code    reg	       reg

# J-type:  _  _  _  _ | _  _  _  _  _
#                OP code    Address

# X-type:  _  _  _  _ | _  _  _   _  _
#                OP code    [No options]

# F-Type _  _  _  _ | _  _  _ |  _ |  _
#                OP code    Reg  Flag   Flag


# yy & p - copy paste
# dd = delete line
# shift i = start typing in front of line
# shift a = start typing at end of line
# x = delete single char at cursor



#Register 1 holds address to be loaded.  The value inside is incremented by 1 after the load.  (Should not violate rules, because it writes to a register, and loads from memory).
# ################################################################################
# 1000  shf			F-Type, Shifts a Register left if LSB flag is set to 1, right if set to 0.
# 				Bit before means shift 1 times or 4 times.
# 1001 movi			I-Type - Moves a 5-bit number into 3rd internal register (%I3)
#
# 1010  cmp_int			H-Type
# ################################################################################
# Compares internal Registers 0-3 to a external register of choice (_ _ |  _ _ _)
# 1011  ba			J-Type
# 1100  ble			J-Type
# 1101  bne			J-Type
# 1110  inc			F-Type, Increments internal Register A or B for flag
# 1111  Halt			X-Type
# ################################################################################



# 1 -----------------------------------

# X Type _ _ _ | all 0's

# 2 -----------------------------------



# 3 -----------------------------------

# print trickyOpCode[0]

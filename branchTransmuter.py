import math

def generateConstantCode(address):
    # Its a giant sandwich of a case -- loops in gneral
    #CASE 1: Small Immediate Values
    result = []
    if (address < 32):
      result.append("mov_imm "  + str(address))
      result.append("mov_ei r7, i3")
    else:
      shiftAmt = int(math.log((address / 16), 2))
      shiftMod = (shiftAmt%2==0) # If one needs an extra shift somewhere
      leftOver = int(address - (math.pow(2,shiftAmt) * 16))
    #   shiftAmt = shiftAmt if (shiftMod)  else  shiftAmt - 1;
    #   leftOver =  (address % 16) if (shiftMod)  else  address % 16 + 16
      print "leftOver after shifting is: " + str(leftOver)

      #Shift
      result.append("mov_imm "  + "16")
      result.append("mov_ei r7, i3")
      #Brute force this, optimizations later
    #   print "shift amount is: " + str(shiftAmt)
      for i in range(0, shiftAmt):
        result.append("shf r7," + " 0, "   + "1") #Multiple single shifts
        # print "Shifted Once"

      #CASE 2:  Medium Immediates, just require one add
      if(leftOver != 0): #
        if(leftOver < 32):
        #    print "Entering Case 2"
           result.append("mov_imm " + str(leftOver))
           result.append("mov_ie r2, i2")
           result.append("mov_ei r2, i3")
           result.append("add r7, r2")
           result.append("mov_ei r2, i2") # To return whatever value was in r2
        #CASE 3:  Large Immediates, Require multiple adds Ex: 98 - 64 = 34,
        else:
        #    print "Entering Case 3"
           result.append("mov_ie r2, i2") # Store r2 to return later
           temp = leftOver
           while (temp!=0) :
             leftOver = 31 if (temp >= 31) else temp
             result.append("mov_imm "  + str(leftOver))
             temp = temp - leftOver
             result.append("mov_ei r2, i3")
             result.append("add r7, r2")
        #ENDING FOR CASE 2 & 3
        result.append("mov_ei r2, i2") # To return r2's value
    #CLOSING LINE WITH BRANCH GENERATED OUTSIDE THIS FUNCTION
    return result










def transmute(word, lookup):
    flag = 0  #End bit
    branchI = word[0]
    label = word[1]

    # TRANSMUTE Branch instruction to viable
    if (word[0])=="bg":
        flag = 1  #End bit signals alu for 2nd option
        branchI = "ble"
    elif(word[0])=="be":
        flag = 1
        branchI = "bne"
    else:
        branchI = word[0]

    # print generateConstantCode(lookup[label])
    # print branchI + " r7, " + str(flag)
    result = generateConstantCode(lookup[label])
    finalStr = branchI + " r7, " + " 0, " +  str(flag)
    result.append(finalStr)

    # print result
    return result
    # print branchI
    # print word[1]

    #print lookup[label]

    # Algorithm
    # Case 1: If number is smaller than 32, mov_imm and mov_ei finish
Labels = {
    '1' : 24,
    '2' : 32,
    '3' : 96,
    'HARD' : 96,  #Should be a hard test case
    'CHECK' : 129,
    'YO' : 164,
}

res = transmute(["be", "1"], Labels);
for item in res:
  print item
# transmute(["be", "2"], Labels);
# transmute(["bg", "3"], Labels);
# # transmute(["ble", "CHECK"], Labels);

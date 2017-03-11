# PART I: ASSEMBLER  ##################################################
# THREE STEPS
# [1. Implement a counter that keeps track of what line an instruction is on]
# [2. Write the case for branching that uses relative branching to jump negative or positive
# movements forward
#     - Make sure:
#         1. numbers are signed, given 5 bits for the immediate value for branching]
#                 _ _ _ _ | _ _ _ _ _
# [3. Try-Catch for when assembler doesn't work (using line number to tell you where error is)]
# [4. Put i/o files in the command line]
# [5. Put in case for comments of whole line]
# [6. Put in case for comments of part of line
# 7. IJ types accept hex, decimal values
#
#
#
# PART II: ASSEMBLE CODE ##################################################
# 1. Start rewriting problems #18 & 19 into proper assembly code given our constraints
# 2. Run it through assembler, generate two output files output_18.txt and output_19.txt
# 3. Repeat for problem #17

from bitstring import Bits
import definitions
from definitions import getOp
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('readFile')
parser.add_argument('writeFile')
args = parser.parse_args()

registers = {
    'r0' : 0,
    'r1' : 1,
    'r2' : 2,
    'r3' : 3,
    'r4' : 4,
    'r5' : 5,
    'r6' : 6,
    'r7' : 7,
    'i0' : 0,
    'i1' : 1,
    'i2' : 2,
    'i3' : 3
}

def addComment(newWords):
    theOutputFile.write('    // ')
    for word in newWords:
        theOutputFile.write(word + ' ')
    theOutputFile.write('\n')

def assembleMachineCode(words, theOutputFile):
    # for removing comments from each line
    comment = False
    newWords = []

    for word in words:
        #print("word: " + word)
        if  word[len(word) - 1] == ",":
          word = word.strip(",")  # Strips commas at end

        if "//" in word:  #
            comment = True

        if not comment:
            newWords.append(word)

    #print(len(newWords))
    wordCount = len(newWords)

    print(newWords)
    print "wordcount is: "
    print wordCount

    # halt (x type)
    if wordCount == 1:
        op = getOp(newWords[0])
        theOutputFile.write(format(op, 'b').zfill(4))   #b means write in binary
        theOutputFile.write(format(0, 'b').zfill(5))
        addComment(newWords)

    # IJ types
    elif wordCount == 2:
        print "2 words printed"
        op = getOp(newWords[0])
        print op
        immediate = int(newWords[1])
        print immediate
        theOutputFile.write(format(op, 'b').zfill(4))
        # theOutputFile.write(str(Bits(int = immediate, length = 5).bin))
        print "Success"
        theOutputFile.write(format(immediate, 'b').zfill(5))
        addComment(newWords)

    # R and H types
    elif wordCount == 3:
        # If R Type
        print("should print")
        op = getOp(newWords[0])
        print("should print 2")
        reg1 = registers[newWords[1]]
        print("should print 3")
        reg2 = registers[newWords[2]]

        theOutputFile.write(format(op, 'b').zfill(4))
        theOutputFile.write(format(reg1, 'b').zfill(3))
        theOutputFile.write(format(reg2, 'b').zfill(2))
        addComment(newWords)
        print("should print 4")

    # F types
    elif wordCount == 4: # Shift Op
        print "success"
        print newWords[0]
        op = getOp(newWords[0])
        reg1 = registers[newWords[1]]
        amt = int(newWords[2])
        direction = int(newWords[3])
        theOutputFile.write(format(op, 'b').zfill(4))
        theOutputFile.write(format(reg1, 'b').zfill(3))
        theOutputFile.write(format( amt, 'b').zfill(1))
        theOutputFile.write(format( direction, 'b').zfill(1))
        addComment(newWords)

    #else:
    #    theOutputFile.write('\n')


if __name__ == "__main__":
    print("Jesse Ren's Stupid Simple Python Assembler:\n")
    print("Beginning Assembly now!")

    # input: SampleASM.s
    # output: machineCode.txt
    with open(args.readFile) as theInputFile, open(args.writeFile, 'w') as theOutputFile:
        lineCount = 1
        for line in theInputFile:
            print("Assembling line %d" % lineCount)
            # print line
            words = line.split()

            # try/catch
            try:
                assembleMachineCode(words, theOutputFile)
            except:
                print("Error at line %d" % lineCount)
                break

            # increment count
            lineCount += 1

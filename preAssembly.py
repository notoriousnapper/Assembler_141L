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
from branchTransmuter import transmute
import argparse
from collections import defaultdict

parser = argparse.ArgumentParser()
parser.add_argument('readFile')
parser.add_argument('writeFile')
args = parser.parse_args()

BRANCHES = {
    'bg' : 1, # Doesn't matter what values there are
    'ble' : 1,
    'be' : 2,
    'bne' : 2,
    'ba' : 3
}

LABELS = {} # To be instantiated in first runthrough
LABELS['DEFAULT'] = 0

def addComment(newWords):
    theOutputFile.write('    // ')
    for word in newWords:
        theOutputFile.write(word + ' ')
    theOutputFile.write('\n')

def assembleMachineCode(words, lineCount, theOutputFile):
    # for removing comments from each line
    comment = False
    returnStr = words
    words = line.split()
    newWords = []
    # print "words: " + words[0]
    for word in words:
        #print("word: " + word)
        if  word[len(word) - 1] == ",":
          word = word.strip(",")  # Strips commas at end

        if "//" in word:  #
            comment = True

        if not comment:
            newWords.append(word)

    print("len is: " + str(len(newWords)))
    # if (len!=0):
    wordCount = len(newWords)
    print "============="
    print "Line 3: flag " + str(wordCount)

    print(newWords)
    print "wordcount is: "
    print wordCount
    # halt (x type)
    # Specifically Just model Branch instruction
    if wordCount == 1:
        label = word
        print "label" + label
        if(label.find(':')):  #Label has been found
          label = label.strip(':')
          LABELS[label] = lineCount

    if wordCount == 2:
        print "WORD"
        print "**============="
        print words[0]
        print(BRANCHES.get(words[0]))
        if(BRANCHES.get(words[0])!= None):
            print "PASS"
            branchLogic =  transmute(words, LABELS)
            print branchLogic
            for item in branchLogic:
              theOutputFile.write(item + "\n")

        #   val = "Success"
        else:
          print "Not A Branch Instruction"
        #   print LABELS[label]
        #   LABELS.append(word[1], lineCount)
    # elif wordCount == 2:  # Just Changing Branching
    #     branchI = getOp(newWords[0])
    #     label = getOp(newWords[0])
    #     # addComment(newWords)
    elif wordCount != 1 & (wordCount!=0)  : #
        print "**============="
        print "Writing To File"
        print "words are: " + returnStr
        theOutputFile.write(returnStr)
    # Case of empty line
    else:
        theOutputFile.write('\n')


if __name__ == "__main__":
    print("Jesse Ren's Stupid Simple Python Assembler:\n")
    print("Beginning Assembly now!")
    # input: SampleASM.s
    # output: machineCode.txt
    with open(args.readFile) as theInputFile, open(args.writeFile, 'w') as theOutputFile:
        lineCount = 0 # Assembly starts at 0
        for line in theInputFile:
            print("Assembling line %d" % lineCount)
            # print line
            # try/catch
            try:
                assembleMachineCode(line, lineCount, theOutputFile)
            except:
                print("Error at line %d" % lineCount)
                break
            # increment count
            isLabel = False
            isNewLine = (len(line.split())==0)
            if(not isNewLine): # If its not a newline
                isLabel = ((line.split()[0].find(':'))!=-1)  # If line is Label
                print "Intermediary: "  + line.split()[0]
                print isLabel
                print "length is: " + str(len(line.split()))
            cond = ((not isNewLine) & (not isLabel))
            print "TOTAL CONDITION: " + str(cond)
            if(cond): # if its a label or newline, don't increment
              lineCount += 1
    print "Collected Labels are: "
    # print LABELS["INNER"]
    # print LABELS["LABEL"]
    for x in LABELS:
      print x + ": " + str(LABELS[x])
    #   print LABELS[x]

# ECE 3504 Principles of Computer Architecture
# Project 1: ISA Calculator
# Richard Martinez
# Version: 	1 - 9.27.2023: Read firstInt
#			2 - 9.28.2023: TODO
# Date: September 28, 2023

### PSUEDO-CODE DESCRIPTION:
## INPUT PHASE:
# Print requestNumber1 string to console
# Read firstInt integer from console
# Print requestOperator string to console
# Read operator string from console
# Print requestNumber2 string to console
# Read secondInt integer from console
## CALCULATION PHASE:
# TODO: continue psuedo-code description

# TODO: register assignments
# $s0 = base address of operator string
# $s1 = firstInt
# $s2 = secondInt

# Start of Data Segment
# All static data is stored here
	.data
# Strings
requestNumber1: 	.asciiz "Enter first number: "
requestOperator: 	.asciiz "Enter operator: "
requestNumber2: 	.asciiz "Enter second number: "
newLine:			.asciiz "\n"

# Ascii Codes for Possible Operators
addOperator:		.word 0x2b
subOperator:		.word 0x2d
mulOperator:		.word 0x2a
divOperator:		.word 0x2f

operatorBuffer:
# Align this with the next possible word
# so we can deference the address using lw without an exception
.align 2
# Allocate one byte of space for the operator char
# Plus one byte for the null terminator
.space 2

# Start of Text Segment
	.text
	.globl main
	
# Main function
main:
	# Push $ra to stack
	# We need this address later to return to system exit
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	# Print firstInt request string to console
	la $a0, requestNumber1
	jal printString
	
	# Read firstInt from console into $s1
	jal readInt
	move $s1, $v0
	
	# Print operator request string to console
	la $a0, requestOperator
	jal printString
	
	# Read operator char from console into $s0
	la $a0, operatorBuffer	# Where to place return string
	li $a1, 2				# Size of string
	jal readString
	move $s0, $a0
	
	# Print new line for clarity
	la $a0, newLine
	jal printString
	
	# Print secondInt request string to console
	la $a0, requestNumber2
	jal printString
	
	# Read secondInt from console into $s2
	jal readInt
	move $s2, $v0
	
	# Dereference the address for the operator to get the ascii code
	lw $s0, 0($s0)
	
	# AT THIS POINT:
	# $s0 = ascii code for operator char
	# $s1 = firstInt
	# $s2 = secondInt
	
	# Pull $ra from stack
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	# Return and exit gracefully
	jr $ra
	
# Read Int function
# NOTE: You need to press enter after your integer
# syscall 5 = read_int
# Param: None
# Return: $v0 = integer
readInt:
	li $v0, 5
	syscall
	
	# Return
	jr $ra
	
# Print String function
# syscall 4 = print_string
# Param: $a0 = base address of string
# Return: None
printString:
	li $v0, 4
	syscall
	
	# Return
	jr $ra
	
# Read String function
# syscall 8 = read_string
# Param: $a0 = buffer to place result into
# Param: $a1 = length of string to read (remember to include null terminator)
# Return: $a0 = base address of string
readString:
	li $v0, 8
	syscall
	
	# Return
	jr $ra

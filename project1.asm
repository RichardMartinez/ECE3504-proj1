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

# Start of Data Segment
# All static data is stored here
	.data
requestNumber1: .asciiz "Enter first number: "
requestOperator: .asciiz "Enter operator: "
requestNumber2: .asciiz "Enter second number: "

# Allocate one byte of space for the operator char
# Plus one byte for the null terminator
operatorBuffer: .space 2

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
	
	# Read firstInt from console into $s0	
	jal readInt
	move $s0, $v0
	
	# Print operator request string to console
	la $a0, requestOperator
	jal printString
	
	# Read operator char from console
	la $a0, operatorBuffer	# Where to place return string
	li $a1, 2				# Size of string
	jal readString
	move $s1, $a0
	
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
# Param: $a1 = length of string to read
# Return: $a0 = base address of string
readString:
	li $v0, 8
	syscall
	
	# Return
	jr $ra

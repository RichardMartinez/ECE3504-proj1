# ECE 3504 Principles of Computer Architecture
# Project 1: ISA Calculator
# Richard Martinez
# Version: 1
# Date: September 27, 2023

# TODO: A psuedo-code description

# TODO: register assignments

# Start of Data Segment
	.data
requestNumber1: .asciiz "Enter first number: "
requestOperator: .asciiz "Enter operator: "
requestNumber2: .asciiz "Enter second number: "

# Start of Text Segment
	.text
	.globl main
	
# Main function
main:
	# Push $ra to stack
	# We need this address later to return to system exit
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	# Print first request string to console
	la $a0, requestNumber1
	jal printString
	
	# Read firstInt from console into $s0	
	jal readInt
	move $s0, $v0
	
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

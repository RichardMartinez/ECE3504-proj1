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
	li $v0, 4
	syscall
	
	# Read firstInt from console	
	jal readInt
	
	# Put firstInt into $s0
	move $s0, $v0
	
	# Pull $ra from stack
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	# Return and exit gracefully
	jr $ra
	
# Read Int function
readInt:
	# syscall 5 = read_int
	li $v0, 5
	syscall
	
	# Return
	jr $ra

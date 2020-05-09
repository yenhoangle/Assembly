.data
	FirstPrompt: .asciiz "Please enter the first number: \n"
	SecondPrompt: .asciiz "Please enter the second number: \n"
	PrintSmaller: .asciiz "The first number is less than the second number. \n"
	PrintGreater: .asciiz "The first number is greater than the second number. \n"
	PrintEqual: .asciiz "The first number is equal to the second number. \n" 
.text
	main:
		li $v0, 4 #printing prompt
		la $a0, FirstPrompt
		syscall
		li $v0, 5
		syscall
		move $t0, $v0 #save first number
		li $v0, 4 #printing prompt
		la $a0, SecondPrompt
		syscall
		li $v0, 5
		syscall
		move $t1, $v0 #save second number
		
		bgt $t0, $t1, great
		slt $s0, $t0, $t1 #s0=1 if t0<t1
		bne $s0, $zero, less
		beq $t0, $t1, equal
				
	great:
		li $v0, 4
		la $a0, PrintGreater
		syscall
		b exit
	less:
		li $v0, 4
		la $a0, PrintSmaller
		syscall
		b exit
	equal:
		li $v0, 4
		la $a0, PrintEqual
		syscall
		b exit
	exit:
		li $v0, 10
		syscall

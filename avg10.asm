.data
	numarray: .space 40 #to store 10 numbers
	prompt: .asciiz "Enter a number: "
	newline: .asciiz "\n"
	space: .asciiz " "
	confirm: .asciiz "The numbers you entered are: "
	averageText: .asciiz "The average is: "
	biggerOrEqual: .asciiz "The numbers that are bigger than or equal to the average are: "
.text
main:
	li $s0, 10000 #store current min
	li $s1, -10000 #store current max
	li $t1, 40 #counter for 10 numbers
	li $t0, 0 #stores current array offset

while: #loop that process entering numbers from console
	beq $t0, $t1, conf
	li $v0, 4
	la $a0, prompt
	syscall	
	li $v0, 5
	syscall
	sw $v0, numarray($t0)
	jal min
	jal max
	add $t0, $t0, 4 #increase array offset pointer
	j while	
exit:
	li $v0, 10
	syscall
	
min: #calculate min
	lw $s4, numarray($t0) #load current value in array
	blt $s0, $s4, done
	move $s0, $s4
	j done
	
max: #calculate max
	lw $s4, numarray($t0) #load current value in array
	bgt $s1, $s4, done
	move $s1, $s4
	j done

conf: #prints the confirmation message after entering numbers
	li $v0, 4
	la $a0, confirm
	syscall
	li $t0, 0 #reset offset counter
	
repeatNumLoop: #loop that prints numbers entered
	beq $t0, $t1, printAvg
	li $v0, 1
	lw $a0, numarray($t0) #print
	syscall
	li $v0, 4
	la $a0, space
	syscall
	add $t0, $t0, 4 #increase offset counter
	j repeatNumLoop
done:
	jr $ra
	
printAvg:
	#print newline
	li $v0, 4
	la $a0, newline
	syscall
	#calculate average: (min + max)/2
	add $s3, $s0, $s1
	div $s3, $s3, 2 #s3 stores the integer average
	li $v0, 4
	la $a0, averageText
	syscall
	li $v0, 1
	move $a0, $s3
	syscall
	j bigOrEq
bigOrEq:
	#print newline
	li $v0, 4
	la $a0, newline
	syscall
	#print text for bigger or equal
	li $v0, 4
	la $a0, biggerOrEqual
	syscall
	li $t0, 0 #new offset counter for printing bigger or equal loop
	
bigOrEqLoop:
	beq $t0, $t1, exit
	jal beqComp
	add $t0, $t0, 4
	j bigOrEqLoop
beqComp:
	lw $a1, numarray($t0) #load current value to compare in a1	
	blt $a1, $s3, done #if less than avg, don't print
	li $v0, 1
	move $a0, $a1
	syscall
	#print a space after the number
	li $v0, 4
	la $a0, space
	syscall
	j done


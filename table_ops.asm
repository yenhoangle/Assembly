.data
	menu_intro: .asciiz "Please select the table operation:\n"
	menu_1: .asciiz "- Print a row [1]\n"
	select_row: .asciiz "Please enter row number:\n"
	menu_2: .asciiz "- Print a column [2]\n"
	select_col: .asciiz "Please enter column number:\n"
	menu_3: .asciiz "- Print the entire table [3]\n"
	menu_4: .asciiz "- Multiply a row by a constant [4]\n"
	select_const: .asciiz "Please enter a number for the constant:\n"
	menu_5: .asciiz "- Add any two rows and place it in any given row [5]\n"
	select_row_replace: .asciiz "Please enter the row to replace:\n"
	menu_6: .asciiz "- Swap any two rows [6]\n"
	menu_7: .asciiz "- Swap any two cells [7]\n"
	menu_8: .asciiz "- Print any cell [8]\n"
	printing_message: .asciiz "Printing...\n"
	op_complete: .asciiz "Table operation is complete.\n"
	menu_9: .asciiz "- Exit [9]\n"
	space: .asciiz " "
	newline: .asciiz "\n"
	table: #hard coded table
		.word 1, 2, 3
		.word 10, 20, 30
		.word 100, 200, 300
.text
main:
menu_loop:
	move $s6, $ra
	li $t0, 0 #index
	li $t1, 3 #row size
	li $t2, 3 #col size
	li $t3, 4 #word size
	li $t4, 0 #offset
	#reset choices 
	li $a1, 0
	li $a2, 0
	li $s1, 0
	li $s2, 0	
	beq $s7, 1, print_row
	beq $s7, 2, print_col
	beq $s7, 3, print_table
	beq $s7, 8, print_cell
	beq $s7, 9, exit

	jal print_menu
	jal accept_input
	j menu_loop	
print_menu:
	li $v0, 4
	la $a0, menu_intro
	syscall
	li $v0, 4
	la $a0, menu_1
	syscall
	li $v0, 4
	la $a0, menu_2
	syscall
	li $v0, 4
	la $a0, menu_3
	syscall
	li $v0, 4
	la $a0, menu_4
	syscall
	li $v0, 4
	la $a0, menu_5
	syscall
	li $v0, 4
	la $a0, menu_6
	syscall
	li $v0, 4
	la $a0, menu_7
	syscall
	li $v0, 4
	la $a0, menu_8
	syscall
	li $v0, 4
	la $a0, menu_9
	syscall
	b done
accept_input:
	li $v0, 5
	syscall
	move $s7, $v0 #s7 stores menu option
	b done	
done:
	jr $ra
menu_return:
	move $ra, $s6
	jr $ra
exit:
	li $v0, 10
	syscall
print_cell:
	li $s7, 0 #reset the choice register
	li $v0, 4
	la $a0, select_row
	syscall
	li $v0, 5
	syscall
	move $a1, $v0 #stores row choice
	li $v0, 4
	la $a0, select_col
	syscall
	li $v0, 5
	syscall
	move $a2, $v0 #store column choice
	jal get_first_offset #calculate offset
	li $v0, 4
	la $a0, printing_message
	syscall
	lw $a0, table($s4) #grab value from table and print
	li, $v0, 1
	syscall
	b end_printing
end_printing: #to add a new line before returning to menu
 	li $v0, 4
	la $a0, newline
	syscall
	b menu_return
print_row:
	li $s7, 0 #reset the choice register
	li $v0, 4
	la $a0, select_row
	syscall
	li $v0, 5
	syscall
	move $a1, $v0 #store row choice
	li $a2, 0 #init column
	li $v0, 4
	la $a0, printing_message
	syscall
	j print_row_loop
print_row_loop:
	beq $a2, 3, end_printing
	jal get_first_offset
	lw $a0, table($s4) #grab value from table and print
	li, $v0, 1
	syscall
	li $v0, 4
	la $a0, space
	syscall
	addi $a2,$a2, 1
	j print_row_loop
print_col:
	li $s7, 0 #reset the choice register
	li $v0, 4
	la $a0, select_col
	syscall
	li $v0, 5
	syscall
	move $a2, $v0 #store column choice
	li $a1, 0 #init row
	li $v0, 4
	la $a0, printing_message
	syscall
	j print_col_loop
print_col_loop:
	beq $a1, 3, end_printing
	jal get_first_offset
	lw $a0, table($s4) #grab value from table and print
	li, $v0, 1
	syscall
	li $v0, 4
	la $a0, space
	syscall
	addi $a1,$a1, 1
	j print_col_loop
print_table:
	li $s7, 0 #reset the choice register
	li $a1, 0 #init row
	li $a2, 0 #init col
	li $v0, 4
	la $a0, printing_message
	syscall
	b print_table_outer_loop
print_table_outer_loop:
	move $s5, $ra #stores return address
	beq $a1, 3, menu_return
	jal print_table_inner_loop
	addi $a1, $a1, 1 #increase row counter
	li $a2, 0 #reset inner loop
	li $v0, 4 #format a new line between rows
	la $a0, newline
	syscall
	j print_table_outer_loop		
print_table_inner_loop:
	beq $a2, 3, done
	#calculate offset
	mul $s4, $a1, $t2 #row x col size
	add $s4, $s4, $a2 #prev val + col
	mul $s4, $s4, $t3 #prev val x 4
	lw $a0, table($s4) #grab value from table and print
	li, $v0, 1
	syscall
	li $v0, 4
	la $a0, space
	syscall
	addi $a2,$a2, 1
	j print_table_inner_loop
mult_row_const:
	li $s7, 0 #reset the choice register
	li $v0, 4
	la $a0, select_row
	syscall
	li $v0, 5
	syscall
	move $a1, $v0 #store row choice
	li $v0, 4
	la $a0, select_const
	syscall
	li $v0, 5
	syscall
	move $a3, $v0 #store const choice
mult_row_loop:
add_row:
	li $s7, 0 #reset the choice register
	li $v0, 4
	la $a0, select_row
	syscall
	li $v0, 5
	syscall
	move $a1, $v0 #store row choice
	li $v0, 4
	la $a0, select_row
	syscall
	li $v0, 5
	syscall
	move $s1, $v0 #store row choice
	li $v0, 4
	la $a0, select_row_replace
	syscall
	li $v0, 5
	syscall
	move $a3, $v0 #store row being replaced
add_row_loop:
swap_cell:
	li $s7, 0 #reset the choice register
	li $v0, 4
	la $a0, select_row
	syscall
	li $v0, 5
	syscall
	move $a1, $v0 #store row choice
	li $v0, 4
	la $a0, select_col
	syscall
	li $v0, 5
	syscall
	move $a2, $v0 #store column choice
	#TODO: calculate offset here
	#save value to somewhere
	#save offset to somewhere
	li $v0, 4
	la $a0, select_row
	syscall
	li $v0, 5
	syscall
	move $s1, $v0 #store row choice
	li $v0, 4
	la $a0, select_col
	syscall
	li $v0, 5
	syscall
	move $s2, $v0 #store column choice
	#TODO: calculate offset here
	#swap: move current val into prev offset saved, then move previous value to current offset
swap_row:
	li $s7, 0 #reset the choice register
	li $v0, 4
	la $a0, select_row
	syscall
	li $v0, 5
	syscall
	move $a1, $v0 #store row choice
	li $v0, 4
	la $a0, select_row
	syscall
	li $v0, 5
	syscall
	move $s1, $v0 #store row choice
get_first_offset: #calculating offset and put it in $s4
	mul $s4, $a1, $t2 #row x col size
	add $s4, $s4, $a2 #prev val + col
	mul $s4, $s4, $t3 #prev val x 4
	b done
get_second_offset: #calculating offset and put it in $t4
	mul $t4, $s1, $t2 #row x col size
	add $t4, $t4, $s2 #prev val + col
	mul $t4, $t4, $t3 #prev val x 4
	b done
	

		
	
	

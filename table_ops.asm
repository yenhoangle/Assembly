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
	menu_9: .asciiz "- Exit [9]\n"
.text
menu_loop:
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
exit:
	li $v0, 10
	syscall
print_cell:
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
	move $a2, $v0 #stores column choice
	#TODO: FINISH
	b done
print_row:
	li $v0, 4
	la $a0, select_row
	syscall
	li $v0, 5
	syscall
	move $a1, $v0 #stores row choice
	b done
print_row_loop:
print_col:
	li $v0, 4
	la $a0, select_col
	syscall
	li $v0, 5
	syscall
	move $a2, $v0 #stores column choice
print_col_loop:
print_table_loop:
mult_row_const:
	li $v0, 4
	la $a0, select_row
	syscall
	li $v0, 5
	syscall
	move $a1, $v0 #stores row choice
	li $v0, 4
	la $a0, select_const
	syscall
	li $v0, 5
	syscall
	move $a3, $v0 #stores const choice
mult_row_loop:
swap_cell:
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
	move $a2, $v0 #stores column choice
	li $v0, 4
	la $a0, select_row
	syscall
	li $v0, 5
	syscall
	move $s1, $v0 #stores row choice
	li $v0, 4
	la $a0, select_col
	syscall
	li $v0, 5
	syscall
	move $s2, $v0 #stores column choice
	
swap_row:
	li $v0, 4
	la $a0, select_row
	syscall
	li $v0, 5
	syscall
	move $a1, $v0 #stores row choice
	li $v0, 4
	la $a0, select_row
	syscall
	li $v0, 5
	syscall
	move $s1, $v0 #stores row choice

	

		
	
	

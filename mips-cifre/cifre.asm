.data
	promt:	.asciiz	"Unesite broj: "
	print_label_1:	.asciiz "LR: "
	print_label_2:	.asciiz "RL: "
.text
	main:
		la $a0, promt
		li $v0, 4
		syscall
		
		li $v0, 5
		syscall
		
		move $t5, $v0
		
		la $a0, print_label_1
		li $v0, 4
		syscall
		
		move $a0, $t5
		jal print_number_lr
		
		# new line
		li $a0, '\n'
		li $v0, 11
		syscall
		
		la $a0, print_label_2
		li $v0, 4
		syscall
		
		move $a0, $t5
		jal print_number_rl
	
		# Terminate
		li $v0, 10
		syscall
		
	# $a0 - number
	print_number_lr:
		addi $sp, $sp, -8
		sw $a0, 0($sp)
		sw $ra, 4($sp)
		
		beq $a0, 0, else1
		li $t0, 10
		div $a0, $t0
		mfhi $t0
		
		addi $sp, $sp, -4
		sw $t0, 0($sp)
		
		mflo $a0
		jal print_number_lr
		
		lw $t0, 0($sp)
		addi $sp, $sp, 4
		
		move $a0, $t0
		li $v0, 1
		syscall
		
	  else1:
		
		lw $a0, 0($sp)
		lw $ra, 4($sp)
		addi $sp, $sp, 8
		jr $ra
		
	# $a0 - number
	print_number_rl:
		addi $sp, $sp, -8
		sw $a0, 0($sp)
		sw $ra, 4($sp)
		
		beq $a0, 0, else2
		li $t0, 10
		div $a0, $t0
		
		mfhi $a0
		li $v0, 1
		syscall 
		
		mflo $a0
		jal print_number_rl
		
	  else2:
	  	lw $a0, 0($sp)
	  	lw $ra, 4($sp)
	  	addi $sp, $sp, 8
	  	jr $ra
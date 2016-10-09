.text
	main:
		li $a0, 24435678
		jal neven
		
		move $a0, $v0
		li $v0, 1
		syscall
	
		# Termiante
		li $v0, 10
		syscall
		
	# $a0 - number
	neven:
		addi $sp, $sp, -8
		sw $a0, 0($sp)
		sw $ra, 4($sp)
		
		beq $a0, 0, else
		li $t0, 10
		div $a0, $t0 
		
		mflo $t0	# x / 10
		mfhi $t1    # x % 10
		
		li $t2, 2
		div $t1, $t2
		mfhi $t3
		
		beq $t3, 1, odd
		move $a0, $t0
		jal neven
		addi $v0, $v0, 1
		j else
		
	  odd:
	  	move $a0, $t0
	  	jal neven
		
	  else:
		lw $a0, 0($sp)
		lw $ra, 4($sp)
		addi $sp, $sp, 8
		jr $ra
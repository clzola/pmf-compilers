.text
	main:
		li $a0, 33245
		jal odd10
		
		move $a0, $v0
		li $v0, 1
		syscall
		
		# Terminate
		li $v0, 10
		syscall
		
	# $a0 - number
	odd10:
		addi $sp, $sp, -8
		sw $a0, 0($sp)
		sw $ra, 4($sp)
		
		beq $a0, 0, else
		
		li $t8, 10
		div $a0, $t8
		mflo $t0	# x / 10
		mfhi $t1    # x % 10; cifra
		
		addi $sp, $sp, -4
		sw $t1, 0($sp)
		
		move $a0, $t0
		jal odd10
		
		lw $t1, 0($sp)
		addi $sp, $sp, 4
		
		li $t8, 10
		mulo $v0, $v0, $t8
		add $v0, $v0, $t1
		
		li $t8, 2
		div $t1, $t8
		mfhi $t3
		
		beq $t3, 0, return
		mulo $v0, $v0, 10
		j return
			
	  else:
	  	li $v0, 0
	  	
	  return:
		lw $a0, 0($sp)
		lw $ra, 4($sp)
		addi $sp, $sp, 8
		jr $ra
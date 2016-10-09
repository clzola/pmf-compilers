.text
	main:
		li $a0, 5
		li $a1, 3
		jal binomial
		
		move $a0, $v0
		li $v0, 1
		syscall
		
		# Terminate
		li $v0, 10
		syscall
		
	# $a0 - n
	# $a1 - k
	binomial:
		addi $sp, $sp, -12
		sw $a0, 0($sp)
		sw $a1, 4($sp)
		sw $ra, 8($sp)
		
		beq $a0, $a1, trivia
		beq $a1, 0, trivia
		
		subi $a0, $a0, 1
		subi $a1, $a1, 1
		jal binomial
		
		lw $a0, 0($sp)
		lw $a1, 4($sp)
		
		addi $sp, $sp, -4
		sw $v0, 0($sp)
		
		subi $a0, $a0, 1
		jal binomial
		
		lw $t0, 0($sp)
		addi $sp, $sp, 4
		add $v0, $v0, $t0
		j return
				
	  trivia:
	  	li $v0, 1
	  	j return
		
	  return:
		lw $a0, 0($sp)
		lw $a1, 4($sp)
		lw $ra, 8($sp)
		addi $sp, $sp, 12
		jr $ra
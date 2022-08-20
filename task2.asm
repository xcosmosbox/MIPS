.data
	height:		.word		0
	valid_input:	.word		0
	now_height:	.word		0
	left_bound:	.word		0
	right_bound:	.word		0
	i:		.word		0
	s:		.word		0
	j:		.word		0
	space:		.asciiz		" "
	newLine: 	.asciiz 	"\n"
	prompt:		.asciiz 	"How tall do you want the tower: "
	top:		.asciiz		"A "
	un_top:		.asciiz		"* "
	TEST:		.asciiz		"!TEST!s"
	TEST2:		.asciiz		"#F!"
	
.text
	main:
		#while valid_input == 0
		lw $t0,valid_input
		beq $t0,$zero,while_loop
		
	#exit the program
	# Print newline
	#addi $v0, $0, 4
	#la $a0, newLine
	#syscall
	#addi $v0,$0,4
	#la $a0, TEST
	#syscall
	addi $v0, $0, 10
	syscall	
	
	
	while_loop:
		# print prompt
		addi $v0,$0,4
		la $a0, prompt
		syscall
		
		# read integer into the height
		addi $v0,$0,5
		syscall 
		sw $v0,height
		
		#if height >= 5, then goto for-loop and set valid_input == 1
		addi $t0,$zero,5
		lw $t1,height
		slt $s0,$t1,$t0 # false == height>=5
		beq $s0,$zero,setValidInput
		j while_loop
		
	
	setValidInput:
		#set valid_input = 1
		lw $t0,valid_input
		addi $t0,$t0,1
		sw $t0,valid_input
		j outer_for_loop
		
		
	set_outer_for_loop:
		#set i
		lw $t0,i
		addi $t0,$t0,1
		sw $t0,i
		#j outer_for_loop
		
		#set s
		addi $t1,$zero,0
		sw $t1,s
		#set j
		addi $t2,$zero,0
		sw $t2,j
		
		#NEW LINE ONLY TEST
		#addi $v0, $0, 4
		#la $a0, TEST
		#syscall
		addi $v0, $0, 4
		la $a0, newLine
		syscall
		
		j outer_for_loop
	
	outer_for_loop:
		#check range
		lw $t0,i
		lw $t1,height
		slt $s0,$t0,$t1
		bne $s0,$zero,set_first_inner_for_loop
		j main
		
	set_first_inner_for_loop:
		#calculate the value for temp range at (height+1)*-1
		#left_bound = (height+1)*-1
		#right_bound = -i
		lw $t0,height
		addi $t0,$t0,1
		addi $t1,$zero,-1
		mult $t0,$t1
		mflo $t0
		sw $t0,left_bound
		
		#set right bound
		lw $t1,i
		addi $t2,$zero,-1
		mult $t1,$t2
		mflo $t1
		#addi $t1,$t1,-1 #tips!!!!!!!!
		sw $t1,right_bound
		
		#set s
		lw $t3,left_bound
		sw $t3,s
		
		j first_inner_for_loop
		
		
	first_inner_for_loop:
		#print the space
		addi $v0,$0,4
		la $a0, space
		syscall
		
		#addi $v0, $0, 4
		#la $a0, newLine
		#syscall
		
		#set s
		lw $t0,s
		addi $t0,$t0,1
		sw $t0,s
		
		#check range
		lw $t0,s
		lw $t1,right_bound
		slt $s0,$t0,$t1
		bne $s0,$zero,first_inner_for_loop
		j set_sec_inner_for_loop
	
	
	set_sec_inner_for_loop:
		#set right_bound
		lw $t0,i
		addi $t1,$t0,1
		sw $t1,right_bound
		
		#check j and right_bound
		#lw $t0,j
		#lw $t1,right_bound
		#slt $s0,$t0,$t1
		#bne $s0,$zero,sec_inner_for_loop
		j sec_inner_for_loop
		
		
	sec_inner_for_loop:
		#check i
		lw $t0,i
		beq $t0,$zero,print_top
		j print_un_top
		
	
	print_top:
		#print top
		addi $v0,$0,4
		la $a0, top
		syscall
		
		j end_sec_inner_for_loop
		
	print_un_top:
		#print top
		addi $v0,$0,4
		la $a0, un_top
		syscall
		
		j end_sec_inner_for_loop
		
		
	end_sec_inner_for_loop:
		#set j
		lw $t0,j
		addi $t0,$t0,1
		sw $t0,j	
		
		#check range
		lw $t0,j
		lw $t1,right_bound
		slt $s0,$t0,$t1
		bne $s0,$zero,sec_inner_for_loop
		j set_outer_for_loop
		
		
		
		
		
		
		
		
		
		
		
	
		
		
		
		
		
	
	
		
		
		
		
		
		
	
	
	
	
	

		
		
		

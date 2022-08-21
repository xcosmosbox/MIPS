.data
	tier_one_price:	   .word	9
	tier_two_price:	   .word	11
	tier_three_price:  .word        14
	discount_flag:	   .word	0
	age:	           .word	0
	minors:		   .word	19
	veterans:	   .word	64
	consumption:	   .word	0
	total_cost:	   .word	0
	max_kWh:	   .word	1000
	min_kWh:	   .word	600
	temp_cost:	   .word	0
	gst:		   .word	0
	bill:		   .word	0
	ret_int:	   .word	0
	ret_rem:	   .word	0
	welcom:		   .asciiz	"Welcome to the Thor Electrical Company!\n"
	newLine: 	   .asciiz 	"\n"
	prompt:		   .asciiz 	"Enter your age: "
	prompt2:	   .asciiz	"Enter your total consumption in kWh: "
	prompt3:	   .asciiz	"Mr Loki Laufeyson, your electricity bill is $"
	prompt4:	   .asciiz	"."
.text
	main:
		# print Welcome
		addi $v0,$0,4
		la $a0, welcom
		syscall
	
		# print prompt
		addi $v0,$0,4
		la $a0, prompt
		syscall
		
		# read integer into the age
		addi $v0,$0,5
		syscall 
		sw $v0,age
		
		# if age <= 18, then $s0 = 1
		lw $t0,age
		lw $t1,minors
		slt $s0,$t0,$t1
		bne $s0,$zero,setDiscountFlag #$s0 ==1 ,so $s0 != 0, I'll set the discount_flag to 1
		
		# if age >= 65, then $s0 = 1
		lw $t0,age
		lw $t1,veterans
		slt $s0,$t1,$t0
		bne $s0,$zero,setDiscountFlag #$s0 ==1 ,so $s0 != 0, I'll set the discount_flag to 1
		
		# goto setKwh
		j setkWh
		
		
	setDiscountFlag:
		# set discount_flag = 1
		lw $t2, discount_flag
		addi $t2,$t2,1
		sw $t2,discount_flag
		
		#goto setkWh
		j setkWh
		

	setkWh:
		# print prompt2
		addi $v0,$0,4
		la $a0, prompt2
		syscall
		
		# read integer into the consumption
		addi $v0,$0,5
		syscall 
		sw $v0,consumption
		
		# if consumption > 1000, then $s0 == 1, the branch goto flag_check
		lw $t0,consumption
		lw $t1,max_kWh
		slt $s0,$t1,$t0
		bne $s0,$zero,flag_check
		
		# if consumption > 600, then $s0 == 1, the branch goto cal_tier1
		lw $t0,consumption
		lw $t1,min_kWh
		slt $s0,$t1,$t0
		bne $s0,$zero,cal_tier1
		
		# if  consumption <600, then goto the cal_tier0
		j cal_tier0
		
		
	flag_check:
		#According to discount_flag flag values go to different branches
		lw $t2,discount_flag
		bne $t2,$zero,discount_label
		beq $t2,$zero,un_discount_label		
		
			
	discount_label:
		# Change tier_three_price
		lw $t2,tier_three_price
		sub $t2,$t2,2
		sw $t2,tier_three_price

		# Getting the excess
		lw $t3,consumption
		sub $t3,$t3,1000
		# ((consumption-1000)*tier_three_price)
		mult $t3,$t2
		mflo $t4
		lw $t5,total_cost
		add $t4,$t4,$t5
		sw $t4,total_cost

		# set consumption = 1000
		addi $t6,$zero,1000
		sw $t6,consumption
		j cal_tier1
		
		
		
		
		
	un_discount_label:
		# load tier_three_price
		lw $t2,tier_three_price

		# Getting the excess
		lw $t3,consumption
		sub $t3,$t3,1000
		# ((consumption-1000)*tier_three_price)
		mult $t3,$t2
		mflo $t4
		lw $t5,total_cost
		add $t4,$t4,$t5
		sw $t4,total_cost

		# consumption = 1000
		addi $t6,$zero,1000
		sw $t6,consumption
		j cal_tier1
		
		
	
	
	cal_tier1:
		#calculate more than 600 and less than 1000
		# load tier_two_price
		lw $t2,tier_two_price
		
		# Getting the excess
		lw $t3,consumption
		sub $t3,$t3,600
		# ((consumption-600)*tier_two_price)
		mult $t3,$t2
		mflo $t4
		lw $t5,total_cost
		add $t4,$t4,$t5
		sw $t4,total_cost

		# consumption = 600
		addi $t6,$zero,600
		sw $t6,consumption
		j cal_tier0
		
		

		
	cal_tier0:
		#calculate less than 600
		lw $t2,tier_one_price
		lw $t3,consumption
		mult $t3,$t2
		mflo $t4
		lw $t5,total_cost
		add $t4,$t4,$t5
		sw $t4,total_cost
		j cal_gst
	
	cal_gst:
		#calculate gst
		addi $t6,$0,10
		lw $t7,total_cost
		div $t7,$t6
		mflo $t7
		sw $t7,gst
		j cal_bill
	
	cal_bill:
		#calculate bill
		lw $t0,total_cost
		lw $t1,gst
		add $t1,$t1,$t0
		sw $t1,bill
		j get_ret
		
		
	get_ret:
		#Store the integer and remainder of the results to be printed separately
		addi $t1, $0, 100
		lw $t0,bill
        div $t0, $t1
        mflo $t0
        sw $t0, ret_int
        mfhi $t3
        sw $t3, ret_rem
        j end_if
        	
		
		
		
	end_if:	
		# Print Value
		addi $v0, $0, 4
		la $a0, prompt3
		syscall
		
		addi $v0,$0,1
		lw $a0, ret_int
		syscall
		
		addi $v0, $0, 4
		la $a0, prompt4
		syscall
		
		addi $v0,$0,1
		lw $a0, ret_rem
		syscall
		
		# Print newline
		addi $v0, $0, 4
		la $a0, newLine
		syscall
		
#Tell the system this end of program.
addi $v0, $0, 10
syscall
	
	
			
		



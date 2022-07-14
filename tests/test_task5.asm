			.data
prompt_len: .asciiz "Array length: "
prompt_num: .asciiz "Enter num: "
prompt_targ:.asciiz "Enter target: "
space:		.asciiz " "
i:			.word 	0

			.text
main:		# Copy $sp to $fp
			addi $fp, $sp, 0

			# Alloc 4 bytes for local variable my_list
			addi $sp, $sp, -16
			
			# -4($fp) size
			# -8($fp) (my_list)
			# -12($fp) target
			# -16($fp) i

			# Prompt for the array length
            addi $v0, $0, 4
            la $a0, prompt_len
			syscall

			# Read the array length
			addi $v0, $0, 5
			syscall
			sw $v0, -4($fp)

			# Create the array based on the array length
			addi $v0, $0, 9
			lw $t0, -4($fp)
			addi $t0, $t0, 1
			sll $a0, $t0, 2
			syscall
			sw $v0, -8($fp)
			lw $t0, -4($fp)
			sw $t0, ($v0)

            sw $0, -16($fp)
read_loop:	# while i < len(the_list)
			lw $t0, -16($fp)		# i
			lw $t1, -8($fp)			# the_list
			lw $t1, ($t1)			# len(the_list)

			slt $t0, $t0, $t1		# i < len(the_list)
			beq $t0, $0, endfor		# if not true (not jump)

			# Prompt for "Enter number: "
			addi $v0, $0, 4
			la $a0, prompt_num
			syscall

			# Read the number
			addi $v0, $0, 5
			syscall

			# the_list[i] = int(input())
			lw $t0, -8($fp)		# &the_list
			lw $t1, -16($fp)	# i
			sll $t1, $t1, 2		# i *= 4
			add $t0, $t0, $t1	# &the_list + (offset)
			sw $v0, 4($t0)		# skip over length

			# i = i + 1
            lw $t0, -16($fp)
			addi $t0, $t0, 1
			sw $t0, -16($fp)

			j read_loop
			
endfor:		# Prompt for the target
            addi $v0, $0, 4
            la $a0, prompt_targ
			syscall

			# Read target
			addi $v0, $0, 5
			syscall
			sw $v0, -12($fp)

			# Call binary_search(my_list)
			addi $sp, $sp, -16 # make space for 1 argument

			lw $t0, -8($fp)   	# load the address of the start of my_list
			sw $t0, 0($sp)    	# store it as arg 1

			lw $t0, -12($fp)	# load target
			sw $t0, 4($sp)		# store it as arg 2
			
			addi $t0, $0, 0		# low = 0
			sw $t0, 8($sp)		# store it as arg 3
			
			lw $t0, -8($fp)		# &the_list
			lw $t0, ($t0)		# len(the_list)
			addi $t0, $t0, -1	# high = len(the_list) - 1
			sw $t0, 12($sp)		# store it as arg 4

			jal binary_search   # call binary_search
			addi $sp, $sp, 16  # remove the argument

			# print(index)
			add $a0, $v0, $0
			addi $v0, $0, 1
			syscall
			
			# print("\n")
			addi $v0, $0, 11
			addi $a0, $0, 10
			syscall

			addi $sp, $sp, 16

			# Exit the program
			addi $v0, $0, 10  # $v0 = 10 for exiting the program
			syscall

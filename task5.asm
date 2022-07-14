# Your job to fill in! :)

    .data

fill: .asciiz "You haven't started task 5 yet\n"

    .text

la $a0, fill
addi $v0, $0, 4
syscall

addi $v0, $0, 10
syscall

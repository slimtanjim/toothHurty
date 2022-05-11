###########################################################
#  Assignment #: 1
#  Name: SM Tanjim
#  ASU email: stanjim@asu.edu
#  Course: CSE/EEE230, TTh 6:00pm
#  Description: This is my first assembly language program.
#               It prints "Hello world" and "This is my first MIPS program.".
###########################################################

#data declarations: declare variable names used in program, storage allocated in RAM

                .data
message1:       .asciiz "Hello world.\n"
message2:       .asciiz "This is my first MIPS program.\n" #create a string containing "this ...program"

#program code is contained below under .text
                .text
                .globl    main    #define a global function main

# the program begins execution at main()
main:
        la      $a0, message1       # $a0 = address of message1   --load address
        li      $v0, 4              # $v0 = 4  --- this is to call print_string()   --load immediate
        syscall                 # call print_string()

        la      $a0, message2
        li      $v0, 4
        syscall                 # call print_string()


        jr      $ra             # return        --jump register

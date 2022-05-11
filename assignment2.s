#################################################
#	Assignment #:2
#	Name: SM Tanjim
# 	ASU email: stanjim@asu.edu
#	course: CSE/EEE230, TTh 6:00pm
#   Description: This program prints two numbers
#               and their sum and difference
#################################################

                .data
# showes output in a nice string order
msg1:           .asciiz "num1 is: "
msg2:           .asciiz "\nnum2 is: "
msg3:           .asciiz "\nnum1+num2 = "
msg4:           .asciiz "\nnum1-num2 = "

#initilize the ints
num1:           .word 92413     #decimal number
num2:           .word 0xD4B     #hex number D4B, 0x because hex number



                .text
                .globl     main
main:
##### first strings
        la      $a0, msg1   #loads msg1 address    # "num1 is: "
        li      $v0, 4      #calls pritn_string
        syscall             #prints the first string
    ##### first int
        lw      $a0, num1   #load the "word" number to $a0
        li      $v0,1       # calls print_int
        syscall             #execute

##### second string
        la      $a0, msg2   #loads msg1 address     #"\n num2 is: "
        li      $v0, 4      #calls pritn_string function
        syscall             #prints the second number
    ##### second int
        lw      $a0, num2   #load the "word" number to $a0
        li      $v0,1       # calls print_int
        syscall             #execute



################################the arithmatic part

#reinnitialize the numbers becasue it's "free" after syscall printes it
        lw      $t0, num1   #loads int in num1 to temp reg 0
        lw      $t1, num2   #loads int in num2 to temp reg 1

######## addition  ######## substracition
    add $s0, $t0, $t1   # the sum is stored in $s0
    sub $s1, $t0, $t1   # the difference is stored in $s1

##### third string
        la      $a0, msg3   #loads msg3 address     #num1+num2 = XXX
        li      $v0, 4      #calls pritn_string function
        syscall             #prints the first number
    ##### sum int
        move    $a0, $s0    #move sum value to $a0
        li      $v0, 1      # call print_int
        syscall             #exectute

##### fourth string
        la      $a0, msg4   #loads msg4 address     #num1-num2 = XXX
        li      $v0, 4      #calls pritn_string function
        syscall             #prints the first number
    ##### fourth int
        move    $a0, $s1    #move sum value to $a0
        li      $v0, 1      # call print_int
        syscall             #exectute


        jr      $ra # jump register to return





#################################################
#    Assignment #:4
#    Name: SM Tanjim
#     ASU email: stanjim@asu.edu
#    course: CSE/EEE230, TTh 6:00pm
#   Description: This program takes in user input
#                   about student and shoes the cost of
#                   attending college or none if no credit
#################################################




## main thuings to focus

#int residentialStatus;
#int numOfCredits;
#int roomAndBoard;

#int tuition;
#int totalCost;

####



                    .data
# strings to ask for input
msg1:       .asciiz "What is your residential status (1 for in-state or 2 for out-of-state)?\n"
msg2:       .asciiz "How many credits to take?\n"
msg3:       .asciiz "Do you need room and board (0 for yes, 1 for no)?\n"



msg5:       .asciiz "You are not taking any credits in the school\n"

#final message
msg4a:      .asciiz "\nYour total cost is "
#
msg4b:      .asciiz " for the number of credits of "


                    .text
                    .globl   main
main:

#ask 1st question
#in-state $s0 ------------
                    # "What is your residential status (1 for in-state or 2 for out-of-state)?"
    la      $a0, msg1
    li      $v0, 4
    syscall

                    #records residetial status
    li      $v0, 5
    syscall

                    #store the decession value in $s0
    move    $s0, $v0
    # $s0 has in-state or out of state (1/2 value )





#ask 2nd question
#credit- s1 ------------
    la      $a0, msg2 #How many credits to take?
    li      $v0, 4
    syscall


    li      $v0, 5
    syscall

                    #store value in $s1
    move    $s1, $v0
    #$s1 has the number of credit ~15 or something





#ask 3rd question
#room - s2 ------------
    la      $a0, msg3 #Do you need room and board (0 for yes, 1 for no)?
    li      $v0, 4
    syscall


    li      $v0, 5
    syscall

    move    $s2, $v0
    #s2 has 0 for yes,,, 1 for no  room and boarding










#calculations for the students#######################




######### decision portions##############################

#if (numOfCredits <= 0)
#    printf("You are not taking any credits in the school\n");

#based on credit taking in s1
#branch  to if s1 >= 0 #taking no credit prints QuickAction

#bgez $s1, Target
# t6 tru or false
# if s1 is greater then
    li $t7, 1
    slt $t6, $t7, $s1
#if it is greater go then go to targer
    beq  $t6, $zero , Target                    # goes to taeger if zero credit or less
#if credit not 0 do the operations below





li $t3, 1

li $t1, 200 # used to -----multiply --------with number of credit
li $t2, 350 # out of state


li $t0, 3000 # used ot ----------add --------to the tuition
# add if room === 0

    bne $s0, $t3, JumpA  #if  in-state do then j to JumpB

    mul $t1, $s1, $t1    #200       for

    jr   JumpB


JumpA:

    mul $t1, $s1, $t2    # 350     for out of state
# t1 has tuition * credit


JumpB:

    li $t3, 1

    beq $s2, $t3, JumpC
                        #0 need room, if equal to t3(1) add 3000
    add  $t1, $t0, $t1

JumpC: # jumps here because on need to add 3000 for room fee 

    move    $s0, $t1
##############################   $s0   contains the total cost of tuition


    la      $a0, msg4a #Your total cost is
    li      $v0, 4
    syscall



    move    $a0, $s0         #print the tuition fee
    li      $v0, 1
    syscall




    la      $a0, msg4b #for the number of credits of
    li      $v0, 4
    syscall




    move    $a0, $s1         #print the number of credit
    li      $v0, 1
    syscall





            jr Exit




Target:

    la $a0, msg5 #You are not taking any credits in the school\n"
    li $v0, 4
    syscall

    jr      $ra     #then jump register



Exit:
            jr      $ra


.include "macrolib.s"

.global WriterFiles

.eqv	NAME_SIZE 256	# Buffer file name size
.eqv    TEXT_SIZE 4096  # Buffer text size

.data
	default_name: .asciz "testout.txt"      # Default file name

	buffer: .space TEXT_SIZE                # buffer for new string
	file_name: .space NAME_SIZE		# File name
	
	# GLOBAL VARIABLE
	# t3 - buffer new String
	
	# LOCAL VARIABLE
	# s0 - container for '\n'
	# s1 - file name
	# s2 - save file name
	# s3 - symbol file name
	# s4 - save file descriptor
	# s5 - negative t0 ( length string)
	# s6 - save length string 
	# s7 - container for symbol string
	# s8 - container answer user
	# s9 - container 'y'
	# s10 - container 'n'
	
.text
WriterFiles:
	# Comeback pointer on start address
	neg s5 t0
	add t2 t2 s5
	
	la t3 buffer
	mv s6 t0
	
	# Copy letters address t2 in buffer
	while:
		beqz s6 exit_while
		lb s7 (t2)
		sb s7 (t3)
		addi t2 t2 1
		addi t3 t3 1
		
		addi s6 s6 -1
		b while
	exit_while:
	
	
    	# Message about input file name
	message("Input file name: ")
	
	# Input file name
    	input_file_name
    
    	# Remove newline
    	li  s0 '\n'
    	la  s1  file_name
    	mv  s2 s1 
    
    	loop:
    		lb s3  (s1)
    		beq s0 s3 exit_loop
    		addi s1 s1 1
    		b   loop
    	exit_loop:
    	
    	# Check name is null
    	beq s2 s1 default
    	sb  zero (s1)
    	mv   a0, s2 
    	b out
    	
    	# Defualt name block
    	default:
    		la a0, default_name
    
    	out:
    	# Open file for writing
    	open_file_write            
    	mv   s4, a0

    	# Write to file just opened
    	write_to_file(s4, buffer, TEXT_SIZE)          
    
    	# Close the file
	close_file(s4)
    	
    	# Question info in console
    	message("Do you want to see text in console? Input y/n\n")
    	li a7 12
    	ecall
    	mv s8 a0
    	
    	newline
    	
    	li s9 'y'
    	li s10 'n'
    	
    	beq s8 s9 answer_yes
    	beq s8 s10 exit_answer
    	jal error_answer
    		
    	
    	answer_yes:
    		la 	a0 buffer
    		li 	a7 4
    		ecall	
    	exit_answer:
	
	# Destruction of subroutine variables
    	zeroing_variable(s0)
    	zeroing_variable(s1)
    	zeroing_variable(s2)
    	zeroing_variable(s3)
    	zeroing_variable(s4)
	zeroing_variable(s5)
    	zeroing_variable(s6)
    	zeroing_variable(s7)
    	zeroing_variable(s8)
    	zeroing_variable(s9)
    	zeroing_variable(s10)
    	
	ret

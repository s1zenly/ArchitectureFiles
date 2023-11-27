.include "macrolib.s"

.global ReaderFiles

.eqv    NAME_SIZE 256	# Buffer file name size
.eqv    TEXT_SIZE 4096	# Buffer text size

.data
	file_name:  .space NAME_SIZE	    # Name file
	strbuf:	    .space TEXT_SIZE        # Buffer for text

.text
ReaderFiles:		
	# GLOBAL VARIABLE
	# t0 - length text
	# t1 - adress start buffer
	
	# LOCAL VARIABLE
	# s0 - container for '\n'
	# s1 - buffer file name
	# s2 - symbol file name
	# s3 - container for -1 ( number error open or read )
	# s4 - discriptor file
	
	
	    	# Message about input file path
		message("Input file path: ")
	    	# Input file path
	    	input_file_name
	    
	    	# Remove newline
	    	li	s0 '\n'
	    	la	s1 file_name
	    
	    	loop:
			lb   s2 (s1)
		    	beq  s0 s2 exit_loop  
		    	addi s1 s1 1
		    	b	loop
	    	exit_loop:
	
	    	# Add zero to the end string
	    	sb	zero (s1)
	    	
	    	# Open file for reading
	    	open_file_read
	    	
            	# Check on correct open file    		
	    	li	s3 -1			
	    	beq	a0 s3 error_file_name
	    	mv   	s4 a0       	

	    	# Read info from the open file
	    	li   a7 63       
	    	mv   a0 s4       
	    	la   a1 strbuf   
	    	li   a2 TEXT_SIZE 
	    	ecall
	    
	    	# Check on correct reading
	    	beq	a0 s3 error_read
	    	mv   	t0 a0       	       
	    
	    	# Close the file
	    	close_file(s4)           
	    	
	    	# Save string address
	    	la t1 strbuf  
	    	
	    	# Destruction of subroutine variables
	    	zeroing_variable(s0)
	    	zeroing_variable(s1)
	    	zeroing_variable(s2)
	    	zeroing_variable(s3)
	    	zeroing_variable(s4)
	    	    	
	ret
	

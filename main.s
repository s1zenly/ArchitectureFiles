.include "macrolib.s"

.global main

main:
	# Read file
	jal ReaderFiles
	
	# Logic method
	jal UpperCase
	
	# Write file
	jal WriterFiles
	
	exit

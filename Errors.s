.include "macrolib.s"

.global error_file_name
.global error_read
.global error_answer

Errors:
	error_file_name:
		message("Incorrect file name\n")
		exit
	error_read:
		message("Incorrect read operation\n")
		exit
	error_answer:
		message("You input other letter")
		exit

name <- readline("Please enter your name: ")
phone <- readline("please enter your phone number: ")

p1 <- substr(phone, 1, 3)
p2 <- substr(phone, nchar (phone) -3, nchar (phone))
#p2 <- substr(phone, -3, -1) 
#To extract characters from the end, nchar() must be used.

cat ("Hi", toupper(name), ". A verification code has been sent to ", p1 , "-XXXXX",p2)
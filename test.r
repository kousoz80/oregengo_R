main:
  count i#
  char buf$(64)
  long rr#(80)

  for i#=0 to 79
  i#, rr#(i#)=
  next i#

  "Hello World", buf, strcpy
  buf, prints nl

  for i#=0 to 79
  rr#(i#), printd " ", prints 
  next i#
  nl
  end

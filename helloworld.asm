; Hello World program
SECTION   .data
msg   db  'Hello World', 0Ah   ; Assing to msg variable string, with line feed char


SECTION   .text
global    _start


_start:
  mov   edx, 13               ; number of bytes to write (plus 0Ah)
  mov   ecx, msg              ; move msg memory address to ecx
  mov   ebx, 1                ; Select STDOUT
  mov   eax, 4                ; Invoke SYS_WRITE (kernel opcode 4)
  int 80h

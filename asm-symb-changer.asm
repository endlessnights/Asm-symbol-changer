.386 
.model Flat 
.Stack 256 
.data 
message db 'Please enter something: $' 
num equ 2

.code 
start: 
main proc 
jmp start1 

change_char: 
mov cx,num
dec cx ;decrement, because of cx=0 - one execution
dec cx
 
loop1:
mov dl,08h ;backspace 
mov ah,02h ;symbol output
int 21h
mov dl,20h ;space
mov ah,02h ;symbol output 
int 21h
mov dl,8h ;backspace 
mov ah,02h ;symbol output 
int 21h
loop loop1

mov dl,8h ;backspace 
mov ah,02h ;symbol output
int 21h

mov dl,'*' 
mov ah,02 ;print '*' on place of first 'w'
int 21h

jmp reset

start1: 
mov edx, offset message 
mov ah,09h 
int 21h 

xor ax,ax ;xor of 16 bit registers, otherwise rubbish in output
xor dx,dx

reset:
xor bl,bl

doit: 
mov ah,01h ;keyboard input
int 21h
cmp al,1bh ;check of ESC button pressed
je doexit ;if ESC pressed - then terminate program
cmp al,'w' ;otherwise проверяем нажатие "w"
jne reset ;если НЕ "w", то обнуляем 8 битные регистры
inc bl
cmp bl,num
jne doit ;если введен символ "W", то повторяем ввод с проверкой
jmp change_char ;если bl=2 - т.е. введено уже 2 символа "w" подряд, то заменяем символы звездочкой

doexit:
retn

main endp 
end start 
end

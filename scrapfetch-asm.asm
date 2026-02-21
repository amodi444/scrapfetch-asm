
section .data
	a1 db 27,"[32m@@@@@@@@@::.....:@@@ scrapfetch-asm 1.0",10,0
	a2 db "@: :..... ......:@@@ %s@",0
	a21 db "%s",10,0
	a3 db ":  ....:-===++++@@@@ ----------------------",10,0
	a4 db ":. .=++++++++===::@@ Kernel: %s",10,0
	a5 db "@.  :+===-..... ..:@ OS - %s",10,0
	a6 db "@ .. .....:-==+:  .@ DE - %s",10,0
	a7 db "@@..====+++++++=. .: Scrap is %s on your device!",10,0
	a8 db "@@@@++=+==--:.... .:",10,0
	a9 db "@@@::..... ......:@@",10,0
	a10 db "@@@:... ..:@@@@@@@@@",27,"[0m",10,0


	buffer times 256 db 0
	mode db "r",0
	cmd1 db "uname -r",0
	cmd2 db "whoami",0
	cmd3 db "uname -n",0
	cmd4 db "source /etc/os-release && echo $NAME",0
	cmd5 db "echo $XDG_CURRENT_DESKTOP",0
	cmd6 db "type scrap >/dev/null 2>&1 && echo installed || echo not installed",0
section .bss
	stream resq 1

section .text
	global main
	extern printf, fgets, popen, pclose
main:
	push rbp
	mov rbp, rsp
	
	mov rdi, a1
	call printf
	
	mov rdi, cmd2
	mov rsi, a2
	call .shell_read
	
	mov rdi, cmd3
	mov rsi, a21
	call .shell_read
	
	mov rdi, a3
	call printf

	mov rdi, cmd1
	mov rsi, a4
	call .shell_read
	
	mov rdi, cmd4
	mov rsi, a5
	call .shell_read
	
	mov rdi, cmd5
	mov rsi, a6
	call .shell_read

	mov rdi, cmd6
	mov rsi, a7
	call .shell_read

	mov rdi, a8
	call printf
	
	mov rdi, a9
	call printf

	mov rdi, a10
	call printf
	jmp .exit
.shell_read:
	push rbp
	mov rbp,rsp
	sub rsp, 32

	mov [rbp-8], rdi
	mov [rbp-16], rsi
	
	mov rdi, [rbp-8]
	mov rsi, mode
	call popen

	mov [stream], rax
	call .fgetsasm

	mov rdi, [stream]
	call pclose

	mov rdi,[rbp-16]
	mov rsi, buffer
	call printf
	

	leave
	ret
.fgetsasm:
	mov rdi, buffer
	mov rsi, 256
	mov rdx, [stream]
	call fgets
	mov rsi, buffer
.delnl:
	cmp byte[rsi], 0
	je .foundnl
	inc rsi
	jmp .delnl
.foundnl:
	dec rsi
	cmp byte[rsi], 10
	jne .nonl
	mov byte[rsi], 0
.nonl:
	ret
.exit:
	
	mov rdi, 0
	mov rax, 60
	syscall

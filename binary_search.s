.text
.section .rodata
.LC0:
        .string "%d\n"

.text
.globl main
.type main, @function
main:
.LFB0:
        .cfi_startproc
        endbr64
        pushq   %rbp
        .cfi_def_cfa_offset 16
        .cfi_offset 6, -16
        movq    %rsp, %rbp
        .cfi_def_cfa_register 6
        subq    $80, %rsp
        movq    %fs:40, %rax
        movq    %rax, -8(%rbp)
        xorl    %eax, %eax
        movl    $1, -48(%rbp)
        movl    $3, -44(%rbp)
        movl    $5, -40(%rbp)
        movl    $7, -36(%rbp)
        movl    $9, -32(%rbp)
        movl    $11, -28(%rbp)
        movl    $13, -24(%rbp)
        movl    $15, -20(%rbp)
        movl    $8, -60(%rbp)
        movl    $7, -56(%rbp)
        movl    $0, -72(%rbp)
        movl    -60(%rbp), %eax
        subl    $1, %eax
        movl    %eax, -68(%rbp)
        movl    $-1, -64(%rbp)
.L2:
        movl    -72(%rbp), %eax
        cmpl    -68(%rbp), %eax
        jle     .L7
.L3:
        movl    -64(%rbp), %eax
        movl    %eax, %esi
        leaq    .LC0(%rip), %rax
        movq    %rax, %rdi
        movl    $0, %eax
        call    printf@PLT
        movq    -8(%rbp), %rdx
        subq    %fs:40, %rdx
        je      .L9
        call    __stack_chk_fail@PLT
.L9:
        leave
        .cfi_def_cfa 7, 8
        ret
        .cfi_endproc
.L7:
        movl    -72(%rbp), %edx
        movl    -68(%rbp), %eax
        addl    %edx, %eax
        shrl    $31, %edx
        addl    %edx, %eax
        sarl    %eax
        movl    %eax, -52(%rbp)
        movl    -52(%rbp), %eax
        cltq
        movl    -48(%rbp,%rax,4), %eax
        cmpl    %eax, -56(%rbp)
        jne     .L4
        movl    -52(%rbp), %eax
        movl    %eax, -64(%rbp)
        jmp     .L3
.L4:
        cmpl    %eax, -56(%rbp)
        jle     .L5
        movl    -52(%rbp), %eax
        addl    $1, %eax
        movl    %eax, -72(%rbp)
        jmp     .L2
.L5:
        movl    -52(%rbp), %eax
        subl    $1, %eax
        movl    %eax, -68(%rbp)
        jmp     .L2
        .size   main, .-main
        .section .note.GNU-stack,"",@progbits          

        .text
        .section .rodata
.LC0:
        .string "%d\n"

        # main 함수 시작
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

        # 스택 초기화 및 배열 값 저장
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

        # 변수 초기화
        movl    $8, -60(%rbp)      # array_size = 8
        movl    $7, -56(%rbp)      # target = 7
        movl    $0, -72(%rbp)      # low = 0
        movl    -60(%rbp), %eax    # high = array_size - 1
        subl    $1, %eax
        movl    %eax, -68(%rbp)
        movl    $-1, -64(%rbp)     # result_index = -1

.L2:    # while (low <= high)
        movl    -72(%rbp), %eax    # low
        cmpl    -68(%rbp), %eax    # high
        jle     .L7                # low <= high ? 반복 실행

.L3:    # 종료 시 출력 및 정리
        movl    -64(%rbp), %eax    # result_index
        movl    %eax, %esi
        leaq    .LC0(%rip), %rax
        movq    %rax, %rdi
        movl    $0, %eax
        call    printf@PLT

        # 함수 종료
        movq    -8(%rbp), %rdx
        subq    %fs:40, %rdx
        je      .L9
        call    __stack_chk_fail@PLT
.L9:
        leave
        .cfi_def_cfa 7, 8
        ret
        .cfi_endproc

.L7:    # while 루프 내부 (중간 계산 및 조건 확인)
        # mid = (low + high) / 2
        movl    -72(%rbp), %edx    # low
        movl    -68(%rbp), %eax    # high
        addl    %edx, %eax
        shrl    $31, %edx
        addl    %edx, %eax
        sarl    %eax
        movl    %eax, -52(%rbp)

        # array[mid]와 target 비교
        cmpl    $0, -52(%rbp)      # mid >= 0 확인
        js      .L3
        movl    -52(%rbp), %eax
        cmpl    -60(%rbp), %eax    # mid < array_size 확인
        jge     .L3

        # 조건 확인 후 low, high 업데이트
        movl    -52(%rbp), %eax
        cltq
        movl    -48(%rbp,%rax,4), %eax
        cmpl    %eax, -56(%rbp)    # array[mid] == target?
        jne     .L4
        movl    -52(%rbp), %eax
        movl    %eax, -64(%rbp)    # result_index = mid
        jmp     .L3

.L4:    # array[mid] < target
        cmpl    %eax, -56(%rbp)
        jle     .L5
        movl    -52(%rbp), %eax
        addl    $1, %eax           # low = mid + 1
        movl    %eax, -72(%rbp)
        jmp     .L2

.L5:    # array[mid] > target
        movl    -52(%rbp), %eax
        subl    $1, %eax           # high = mid - 1
        movl    %eax, -68(%rbp)
        jmp     .L2

        .size   main, .-main
        .section .note.GNU-stack,"",@progbits

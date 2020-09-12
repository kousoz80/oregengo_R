// oregengo-R コードジェネレータ定義データ
codegen:
 data "/\/"
 data "\1
"
 data " \:"
 data "\1:
"
 data "\:"
 data "\1:
"
 data " .jge \"
 data " xmm0=rdi
 xmm1=rsi
 xmm1.-xmm0
 jae \1
"
 data " .jlt \"
 data " xmm0=rdi
 xmm1=rsi
 xmm1.-xmm0
 jb \1
"
 data " .jz \"
 data " xmm0=rdi
 xmm1=rsi
 xmm1.-xmm0
 jz \1
"
 data " .jnz \"
 data " xmm0=rdi
 xmm1=rsi
 xmm1.-xmm0
 jnz \1
"
 data " jge \"
 data " rsi-rdi
 jge \1
"
 data " jlt \"
 data " rsi-rdi
 jlt \1
"
 data " jz \"
 data " rsi-rdi
 jz \1
"
 data " jnz \"
 data " rsi-rdi
 jnz \1
"
 data " jmp \"
 data " jmp \1
"
 data " goto\"
 data " jmp \1
"
 data " .+"
 data " xmm0=rdi
 xmm1=rsi
 xmm0.+=xmm1
 rdi=xmm0
"
 data " .-"
 data " xmm0=rdi
 xmm1=rsi
 xmm1.-=xmm0
 rdi=xmm1
"
 data " .*"
 data " xmm0=rdi
 xmm1=rsi
 xmm0.*=xmm1
 rdi=xmm0
"
 data " ./"
 data " xmm0=rdi
 xmm1=rsi
 xmm1./=xmm0
 rdi=xmm1
"
 data " sqrt"
 data " xmm0=rdi
 xmm1=sqrt(xmm0)
 rdi=xmm1
"
 data " (double)"
 data " xmm0=(double)rdi
 rdi=xmm0
"
 data " (_long)"
 data " xmm0=rdi
 rdi=(_long)xmm0
"
 data " (long)"
 data " xmm0=rdi
 rdi=(long)xmm0
"
 data " +"
 data " rdi+=rsi
"
 data " -"
 data " exg rdi,rsi
 rdi-=rsi
"
 data " *"
 data " rax=rdi
 mul rsi
 rdi=rax
"
 data " /"
 data " rdx^=rdx
 rax=rsi
 rax&rax
 jge $+9
 rdx--
 div rdi
 rdi=rax
"
 data " neg"
 data " neg rdi
"
 data " not"
 data " not rdi
"
 data " mod"
 data " rdx^=rdx
 rax=rsi
 rax&rax
 jge $+9
 rdx--
 div rdi
 rdi=rdx
"
 data " swap"
 data " exg rdi,rsi
"
 data " push"
 data " r12=r11
 r11=r10
 r10=r9
 r9=r8
 r8=rdx
 rdx=rsi
 rsi=rdi
"
 data " pop"
 data " rdi=rsi
 rsi=rdx
 rdx=r8
 r8=r9
 r9=r10
 r10=r11
 r11=r12
"
 data " PUSH"
 data " r14=1
 rax=__critical
 (rax)=r14
 rax=__stack_p
 r15=(rax)
 r15--
 r15--
 r15--
 r15--
 r15--
 r15--
 r15--
 r15--
 (rax)=r15
 r14=0
 rax=__critical
 rax=r15
 (rax)=rdi
"
 data " POP"
 data " r14=1
 rax=__critical
 (rax)=r14
 rax=__stack_p
 r15=(rax)
 r15++
 r15++
 r15++
 r15++
 r15++
 r15++
 r15++
 r15++
 (rax)=r15
 r14=0
 rax=__critical
 (rax)=r14
 rax=r15
 rdi=-8(rax)
"
 data " umul"
 data " rax=rdi
 umul rsi
 rdi=rax
"
 data " udiv"
 data " rdx^=rdx
 rax=rsi
 udiv rdi
 rdi=rax
"
 data " and"
 data " rdi&=rsi
"
 data " or"
 data " rdi|=rsi
"
 data " xor"
 data " rdi^=rsi
"
 data " getchar$,"
 data " call getchar
"
 data " inkey$,"
 data " call inkey
"
 data " \(rip),"
 data " r12=r11
 r11=r10
 r10=r9
 r9=r8
 r8=rdx
 rdx=rsi
 rsi=rdi
 rdi=&\1(rip)
"
 data " end"
 data " r14=1
 rax=__critical
 (rax)=r14
 rax=__stack_p
 r15=(rax)
 r15++
 r15++
 r15++
 r15++
 r15++
 r15++
 r15++
 r15++
 (rax)=r15
 r14=0
 rax=__critical
 (rax)=r14
 rax=r15
 rax=-8(rax)
 jmp (rax)
"
 data " return"
 data " r14=1
 rax=__critical
 (rax)=r14
 rax=__stack_p
 r15=(rax)
 r15++
 r15++
 r15++
 r15++
 r15++
 r15++
 r15++
 r15++
 (rax)=r15
 r14=0
 rax=__critical
 (rax)=r14
 rax=r15
 rax=-8(rax)
 jmp (rax)
"
 data " jmp@"
 data " jmp (rdi)
"
 data " call@"
 data " r14=1
 rax=__critical
 (rax)=r14
 rax=__stack_p
 r15=(rax)
 r15--
 r15--
 r15--
 r15--
 r15--
 r15--
 r15--
 r15--
 (rax)=r15
 r14=0
 rax=__critical
 (rax)=r14
 rax=r15
 r15=$+15
 (rax)=r15
 jmp (rdi)
"
 data " .data"
 data " align 8
"
 data " ->\#="
 data " rcx=\1
 rcx+=rdi
 rax=rsi
 (rcx)=rax
"
 data " ->\!="
 data " rcx=\1
 rcx+=rdi
 rax=rsi
 (rcx)=eax
"
 data " ->\%="
 data " rcx=\1
 rcx+=rdi
 rax=rsi
 (rcx)=ax
"
 data " ->\$="
 data " rcx=\1
 rcx+=rdi
 rax=rsi
 (rcx)=al
"
 data " ->\#"
 data " rcx=\1
 rcx+=rdi
 rax=(rcx)
 rdi=rax
"
 data " ->\!"
 data " rcx=\1
 rcx+=rdi
 eax=(rcx)
 ext eax
 rdi=rax
"
 data " ->\%"
 data " rcx=\1
 rcx+=rdi
 ax=(rcx)
 ext ax
 rdi=rax
"
 data " ->\$"
 data " rcx=\1
 rcx+=rdi
 al=(rcx)
 ext al
 rdi=rax
"
 data " ->@\(\)"
 data " r13=\2
 rcx=\1
 rcx+=rdi
 rcx=(rcx)
 r14=1
 rax=__critical
 (rax)=r14
 rax=__stack_p
 r15=(rax)
 r15--
 r15--
 r15--
 r15--
 r15--
 r15--
 r15--
 r15--
 (rax)=r15
 r14=0
 rax=__critical
 (rax)=r14
 rax=r15
 r15=$+36
 (rax)=r15
 rdi=rsi
 rsi=rdx
 rdx=r8
 r8=r9
 r9=r10
 r10=r11
 r11=r12
 jmp (rcx)
"
 data " ->@\"
 data " rcx=\1
 rcx+=rdi
 rcx=(rcx)
 r14=1
 rax=__critical
 (rax)=r14
 rax=__stack_p
 r15=(rax)
 r15--
 r15--
 r15--
 r15--
 r15--
 r15--
 r15--
 r15--
 (rax)=r15
 r14=0
 rax=__critical
 (rax)=r14
 rax=r15
 r15=$+36
 (rax)=r15
 rdi=rsi
 rsi=rdx
 rdx=r8
 r8=r9
 r9=r10
 r10=r11
 r11=r12
 jmp (rcx)
"
 data " ->\"
 data " rcx=\1
 rdi+=rcx
"
 data " (\)#(\#),"
 data " r12=r11
 r11=r10
 r10=r9
 r9=r8
 r8=rdx
 rdx=rsi
 rsi=rdi
 rcx=&\2
 rax=(rcx)
 rax+=rax
 rax+=rax
 rax+=rax
 rcx=&\1
 rcx=(rcx)
 rcx+=rax
 rdi=(rcx)
"
 data " \#(\#),"
 data " r12=r11
 r11=r10
 r10=r9
 r9=r8
 r8=rdx
 rdx=rsi
 rsi=rdi
 rcx=&\2
 rax=(rcx)
 rax+=rax
 rax+=rax
 rax+=rax
 rcx=&\1
 rcx+=rax
 rdi=(rcx)
"
 data " (\)!(\#),"
 data " r12=r11
 r11=r10
 r10=r9
 r9=r8
 r8=rdx
 rdx=rsi
 rsi=rdi
 rcx=&\2
 rax=(rcx)
 rax+=rax
 rax+=rax
 rcx=&\1
 rcx=(rcx)
 rcx+=rax
 eax=(rcx)
 ext eax
 rdi=rax
"
 data " \!(\#),"
 data " r12=r11
 r11=r10
 r10=r9
 r9=r8
 r8=rdx
 rdx=rsi
 rsi=rdi
 rcx=&\2
 rax=(rcx)
 rax+=rax
 rax+=rax
 rcx=&\1
 rcx+=rax
 eax=(rcx)
 ext eax
 rdi=rax
"
 data " (\)%(\#),"
 data " r12=r11
 r11=r10
 r10=r9
 r9=r8
 r8=rdx
 rdx=rsi
 rsi=rdi
 rcx=&\2
 rax=(rcx)
 rax+=rax
 rcx=&\1
 rcx=(rcx)
 rcx+=rax
 ax=(rcx)
 ext ax
 rdi=rax
"
 data " \%(\#),"
 data " r12=r11
 r11=r10
 r10=r9
 r9=r8
 r8=rdx
 rdx=rsi
 rsi=rdi
 rcx=&\2
 rax=(rcx)
 rax+=rax
 rcx=&\1
 rcx+=rax
 ax=(rcx)
 ext ax
 rdi=rax
"
 data " (\)$(\#),"
 data " r12=r11
 r11=r10
 r10=r9
 r9=r8
 r8=rdx
 rdx=rsi
 rsi=rdi
 rcx=&\2
 rax=(rcx)
 rcx=&\1
 rcx=(rcx)
 rcx+=rax
 al=(rcx)
 ext al
 rdi=rax
"
 data " \$(\#),"
 data " r12=r11
 r11=r10
 r10=r9
 r9=r8
 r8=rdx
 rdx=rsi
 rsi=rdi
 rcx=&\2
 rax=(rcx)
 rcx=&\1
 rcx+=rax
 al=(rcx)
 ext al
 rdi=rax
"
 data " (\)#(\#)="
 data " rcx=&\2
 rax=(rcx)
 rax+=rax
 rax+=rax
 rax+=rax
 rcx=&\1
 rcx=(rcx)
 rcx+=rax
 (rcx)=rdi
"
 data " \#(\#)="
 data " rcx=&\2
 rax=(rcx)
 rax+=rax
 rax+=rax
 rax+=rax
 rcx=&\1
 rcx+=rax
 (rcx)=rdi
"
 data " (\)!(\#)="
 data " rcx=&\2
 rax=(rcx)
 rax+=rax
 rax+=rax
 rcx=&\1
 rcx=(rcx)
 rcx+=rax
 rax=rdi
 (rcx)=eax
"
 data " \!(\#)="
 data " rcx=&\2
 rax=(rcx)
 rax+=rax
 rax+=rax
 rcx=&\1
 rcx+=rax
 rax=rdi
 (rcx)=eax
"
 data " (\)%(\#)="
 data " rcx=&\2
 rax=(rcx)
 rax+=rax
 rcx=&\1
 rcx=(rcx)
 rcx+=rax
 rax=rdi
 (rcx)=ax
"
 data " \%(\#)="
 data " rcx=&\2
 rax=(rcx)
 rax+=rax
 rcx=&\1
 rcx+=rax
 rax=rdi
 (rcx)=ax
"
 data " (\)$(\#)="
 data " rcx=&\2
 rax=(rcx)
 rcx=&\1
 rcx=(rcx)
 rcx+=rax
 rax=rdi
 (rcx)=al
"
 data " \$(\#)="
 data " rcx=&\2
 rax=(rcx)
 rcx=&\1
 rcx+=rax
 rax=rdi
 (rcx)=al
"
 data " (\)#(\),"
 data " r12=r11
 r11=r10
 r10=r9
 r9=r8
 r8=rdx
 rdx=rsi
 rsi=rdi
 rax=\2
 rax+=rax
 rax+=rax
 rax+=rax
 rcx=&\1
 rcx=(rcx)
 rcx+=rax
 rdi=(rcx)
"
 data " \#(\),"
 data " r12=r11
 r11=r10
 r10=r9
 r9=r8
 r8=rdx
 rdx=rsi
 rsi=rdi
 rax=\2
 rax+=rax
 rax+=rax
 rax+=rax
 rcx=&\1
 rcx+=rax
 rdi=(rcx)
"
 data " (\)!(\),"
 data " r12=r11
 r11=r10
 r10=r9
 r9=r8
 r8=rdx
 rdx=rsi
 rsi=rdi
 rax=\2
 rax+=rax
 rax+=rax
 rcx=&\1
 rcx=(rcx)
 rcx+=rax
 eax=(rcx)
 ext eax
 rdi=rax
"
 data " \!(\),"
 data " r12=r11
 r11=r10
 r10=r9
 r9=r8
 r8=rdx
 rdx=rsi
 rsi=rdi
 rax=\2
 rax+=rax
 rax+=rax
 rcx=&\1
 rcx+=rax
 eax=(rcx)
 ext eax
 rdi=rax
"
 data " (\)%(\),"
 data " r12=r11
 r11=r10
 r10=r9
 r9=r8
 r8=rdx
 rdx=rsi
 rsi=rdi
 rax=\2
 rax+=rax
 rcx=&\1
 rcx=(rcx)
 rcx+=rax
 ax=(rcx)
 ext ax
 rdi=rax
"
 data " \%(\),"
 data " r12=r11
 r11=r10
 r10=r9
 r9=r8
 r8=rdx
 rdx=rsi
 rsi=rdi
 rax=\2
 rax+=rax
 rcx=&\1
 rcx+=rax
 ax=(rcx)
 ext ax
 rdi=rax
"
 data " (\)$(\),"
 data " r12=r11
 r11=r10
 r10=r9
 r9=r8
 r8=rdx
 rdx=rsi
 rsi=rdi
 rax=\2
 rcx=&\1
 rcx=(rcx)
 rcx+=rax
 al=(rcx)
 ext al
 rdi=rax
"
 data " \$(\),"
 data " r12=r11
 r11=r10
 r10=r9
 r9=r8
 r8=rdx
 rdx=rsi
 rsi=rdi
 rax=\2
 rcx=&\1
 rcx+=rax
 al=(rcx)
 ext al
 rdi=rax
"
 data " (\)#(\)="
 data " rax=\2
 rax+=rax
 rax+=rax
 rax+=rax
 rcx=&\1
 rcx=(rcx)
 rcx+=rax
 (rcx)=rdi
"
 data " \#(\)="
 data " rax=\2
 rax+=rax
 rax+=rax
 rax+=rax
 rcx=&\1
 rcx+=rax
 (rcx)=rdi
"
 data " (\)!(\)="
 data " rax=\2
 rax+=rax
 rax+=rax
 rcx=&\1
 rcx=(rcx)
 rcx+=rax
 rax=rdi
 (rcx)=eax
"
 data " \!(\)="
 data " rax=\2
 rax+=rax
 rax+=rax
 rcx=&\1
 rcx+=rax
 rax=rdi
 (rcx)=eax
"
 data " (\)%(\)="
 data " rax=\2
 rax+=rax
 rcx=&\1
 rcx=(rcx)
 rcx+=rax
 rax=rdi
 (rcx)=ax
"
 data " \%(\)="
 data " rax=\2
 rax+=rax
 rcx=&\1
 rcx+=rax
 rax=rdi
 (rcx)=ax
"
 data " (\)$(\)="
 data " rax=\2
 rcx=&\1
 rcx=(rcx)
 rcx+=rax
 rax=rdi
 (rcx)=al
"
 data " \$(\)="
 data " rax=\2
 rcx=&\1
 rcx+=rax
 rax=rdi
 (rcx)=al
"
 data " \#++"
 data " rcx=&\1
 rax=(rcx)
 rax++
 (rcx)=rax
"
 data " \#--"
 data " rcx=&\1
 rax=(rcx)
 rax--
 (rcx)=rax
"
 data " \!++"
 data " rcx=&\1
 eax=(rcx)
 eax++
 (rcx)=eax
"
 data " \!--"
 data " rcx=&\1
 eax=(rcx)
 eax--
 (rcx)=eax
"
 data " \%++"
 data " rcx=&\1
 ax=(rcx)
 ax++
 (rcx)=ax
"
 data " \%--"
 data " rcx=&\1
 ax=(rcx)
 ax--
 (rcx)=ax
"
 data " \$++"
 data " rcx=&\1
 al=(rcx)
 al++
 (rcx)=al
"
 data " \$--"
 data " rcx=&\1
 al=(rcx)
 al--
 (rcx)=al
"
 data " (\)#,"
 data " r12=r11
 r11=r10
 r10=r9
 r9=r8
 r8=rdx
 rdx=rsi
 rsi=rdi
 rax=&\1
 rax=(rax)
 rdi=(rax)
"
 data " \#,"
 data " r12=r11
 r11=r10
 r10=r9
 r9=r8
 r8=rdx
 rdx=rsi
 rsi=rdi
 rax=&\1
 rdi=(rax)
"
 data " (\)!,"
 data " r12=r11
 r11=r10
 r10=r9
 r9=r8
 r8=rdx
 rdx=rsi
 rsi=rdi
 rax=&\1
 rax=(rax)
 eax=(rax)
 ext eax
 rdi=rax
"
 data " \!,"
 data " r12=r11
 r11=r10
 r10=r9
 r9=r8
 r8=rdx
 rdx=rsi
 rsi=rdi
 rax=&\1
 eax=(rax)
 ext eax
 rdi=rax
"
 data " (\)%,"
 data " r12=r11
 r11=r10
 r10=r9
 r9=r8
 r8=rdx
 rdx=rsi
 rsi=rdi
 rax=&\1
 rax=(rax)
 ax=(rax)
 ext ax
 rdi=rax
"
 data " \%,"
 data " r12=r11
 r11=r10
 r10=r9
 r9=r8
 r8=rdx
 rdx=rsi
 rsi=rdi
 rax=&\1
 ax=(rax)
 ext ax
 rdi=rax
"
 data " (\)$,"
 data " r12=r11
 r11=r10
 r10=r9
 r9=r8
 r8=rdx
 rdx=rsi
 rsi=rdi
 rax=&\1
 rax=(rax)
 al=(rax)
 ext al
 rdi=rax
"
 data " \$,"
 data " r12=r11
 r11=r10
 r10=r9
 r9=r8
 r8=rdx
 rdx=rsi
 rsi=rdi
 rax=&\1
 al=(rax)
 ext al
 rdi=rax
"
 data " \,"
 data " r12=r11
 r11=r10
 r10=r9
 r9=r8
 r8=rdx
 rdx=rsi
 rsi=rdi
 rdi=\1
"
 data " (\)#="
 data " rax=&\1
 rax=(rax)
 (rax)=rdi
"
 data " \#="
 data " rax=&\1
 (rax)=rdi
"
 data " (\)!="
 data " rax=&\1
 rax=(rax)
 rcx=rdi
 (rax)=ecx
"
 data " \!="
 data " rax=&\1
 rcx=rdi
 (rax)=ecx
"
 data " (\)%="
 data " rax=&\1
 rax=(rax)
 rcx=rdi
 (rax)=cx
"
 data " \%="
 data " rax=&\1
 rcx=rdi
 (rax)=cx
"
 data " (\)$="
 data " rax=&\1
 rax=(rax)
 rcx=rdi
 (rax)=cl
"
 data " \$="
 data " rax=&\1
 rcx=rdi
 (rax)=cl
"
 data " data\"
 data " long \1
"
 data " @\(\)"
 data " r13=\2
 r14=1
 rax=__critical
 (rax)=r14
 rax=__stack_p
 r15=(rax)
 r15--
 r15--
 r15--
 r15--
 r15--
 r15--
 r15--
 r15--
 (rax)=r15
 r14=0
 rax=__critical
 (rax)=r14
 rax=r15
 r15=$+28
 (rax)=r15
 rax=\1
 rax=(rax)
 jmp (rax)
"
 data " @\"
 data " r14=1
 rax=__critical
 (rax)=r14
 rax=__stack_p
 r15=(rax)
 r15--
 r15--
 r15--
 r15--
 r15--
 r15--
 r15--
 r15--
 (rax)=r15
 r14=0
 rax=__critical
 (rax)=r14
 rax=r15
 r15=$+28
 (rax)=r15
 rax=\1
 rax=(rax)
 jmp (rax)
"
 data " \"
 data " r14=1
 rax=__critical
 (rax)=r14
 rax=__stack_p
 r15=(rax)
 r15--
 r15--
 r15--
 r15--
 r15--
 r15--
 r15--
 r15--
 (rax)=r15
 r14=0
 rax=__critical
 (rax)=r14
 rax=r15
 r15=$+18
 (rax)=r15
 jmp \1
"
 data NULL

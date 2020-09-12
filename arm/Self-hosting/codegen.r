// oregengo-R for ARM CPUコードジェネレータ定義データ
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
 data " jge \"
 data " r1-r0
 jge \1
"
 data " jlt \"
 data " r1-r0
 jlt \1
"
 data " jz \"
 data " r1-r0
 jeq \1
"
 data " jnz \"
 data " r1-r0
 jne \1
"
 data " jmp \"
 data " jmp \1
"
 data " goto\"
 data " jmp \1
"
 data " +"
 data " r0=r0+r1
"
 data " -"
 data " r0=r1-r0
"
 data " *"
 data " r0=r1*r0
"
 data " /"
 data " lr=&$+36
 sp=sp-4
 (sp)#=lr
 r8=&idiv
 pc=r8
"
 data " neg"
 data " r8=0
 r0=r8-r0
"
 data " not"
 data " r8=&0xffffffff
 r0=r0^r8
"
 data " mod"
 data " lr=&$+36
 sp=sp-4
 (sp)#=lr
 r8=&mod
 pc=r8
"
 data " swap"
 data " r8=r0
 r0=r1
 r1=r8
"
 data " push"
 data " r7=r6
 r6=r5
 r5=r4
 r4=r3
 r3=r2
 r2=r1
 r1=r0
"
 data " pop"
 data " r0=r1
 r1=r2
 r2=r3
 r3=r4
 r4=r5
 r5=r6
 r6=r7
"
 data " PUSH"
 data " sp=sp-4
 (sp)=r0
"
 data " POP"
 data " r0=(sp)
 sp=sp+4
"
 data " umul"
 data " r0=r0*r1
"
 data " udiv"
 data " lr=&$+36
 sp=sp-4
 (sp)#=lr
 r8=&udiv
 pc=r8
"
 data " and"
 data " r0=r0&r1
"
 data " or"
 data " r0=r0|r1
"
 data " xor"
 data " r0=r0^r1
"
 data " getchar$,"
 data " lr=&$+36
 sp=sp-4
 (sp)#=lr
 r8=&getchar
 pc=r8
"
 data " inkey$,"
 data " lr=&$+36
 sp=sp-4
 (sp)#=lr
 r8=&inkey
 pc=r8
"
 data " \(pc),"
 data " r7=r6
 r6=r5
 r5=r4
 r4=r3
 r3=r2
 r2=r1
 r1=r0
 r8=&\1
 r0=pc+r8
"
 data " end"
 data " lr=(sp)#
 sp=sp+4
 pc=lr
"
 data " return"
 data " lr=(sp)#
 sp=sp+4
 pc=lr
"
 data " jmp@"
 data " pc=r0
"
 data " call@"
 data " lr=&$+24
 sp=sp-4
 (sp)#=lr
 pc=r0
"
 data " ->\#="
 data " r8=&\1
 r8=r8+r0
 r9=r1
 (r8)#=r9
"
 data " ->\!="
 data " r8=&\1
 r8=r8+r0
 r9=r1
 (r8)!=r9
"
 data " ->\%="
 data " r8=&\1
 r8=r8+r0
 r9=r1
 (r8)%=r9
"
 data " ->\$="
 data " r8=&\1
 r8=r8+r0
 r9=r1
 (r8)$=r9
"
 data " ->\#"
 data " r8=&\1
 r8=r8+r0
 r0=(r8)#
"
 data " ->\!"
 data " r8=&\1
 r8=r8+r0
 r0=(r8)!
"
 data " ->\%"
 data " r8=&\1
 r8=r8+r0
 r0=(r8)%
"
 data " ->\$"
 data " r8=&\1
 r8=r8+r0
 r0=(r8)$
"
 data " ->@\(\)"
 data " r10=&\2
 r8=&\1
 r8=r8+r0
 r8=(r8)#
 lr=&$+24
 sp=sp-4
 (sp)#=lr
 pc=r8
"
 data " ->@\"
 data " r8=&\1
 r8=r8+r0
 r8=(r8)#
 lr=&$+24
 sp=sp-4
 (sp)#=lr
 pc=r8
"
 data " ->\"
 data " r8=&\1
 r0=r0+r8
"
 data " (\)#(\#),"
 data " r7=r6
 r6=r5
 r5=r4
 r4=r3
 r3=r2
 r2=r1
 r1=r0
 r9=&\2
 r9=(r9)#
 r9=r9+r9
 r9=r9+r9
 r8=&\1
 r8=(r8)#
 r8=r8+r9
 r0=(r8)#
"
 data " \#(\#),"
 data " r7=r6
 r6=r5
 r5=r4
 r4=r3
 r3=r2
 r2=r1
 r1=r0
 r9=&\2
 r9=(r9)#
 r9=r9+r9
 r9=r9+r9
 r8=&\1
 r8=r8+r9
 r0=(r8)#
"
 data " (\)!(\#),"
 data " r7=r6
 r6=r5
 r5=r4
 r4=r3
 r3=r2
 r2=r1
 r1=r0
 r9=&\2
 r9=(r9)#
 r9=r9+r9
 r9=r9+r9
 r8=&\1
 r8=(r8)#
 r8=r8+r9
 r0=(r8)!
"
 data " \!(\#),"
 data " r7=r6
 r6=r5
 r5=r4
 r4=r3
 r3=r2
 r2=r1
 r1=r0
 r9=&\2
 r9=(r9)#
 r9=r9+r9
 r9=r9+r9
 r8=&\1
 r8=r8+r9
 r0=(r8)!
"
 data " (\)%(\#),"
 data " r7=r6
 r6=r5
 r5=r4
 r4=r3
 r3=r2
 r2=r1
 r1=r0
 r9=&\2
 r9=(r9)#
 r9=r9+r9
 r8=&\1
 r8=(r8)#
 r8=r8+r9
 r0=(r8)%
"
 data " \%(\#),"
 data " r7=r6
 r6=r5
 r5=r4
 r4=r3
 r3=r2
 r2=r1
 r1=r0
 r9=&\2
 r9=(r9)#
 r9=r9+r9
 r8=&\1
 r8=r8+r9
 r0=(r8)%
"
 data " (\)$(\#),"
 data " r7=r6
 r6=r5
 r5=r4
 r4=r3
 r3=r2
 r2=r1
 r1=r0
 r9=&\2
 r9=(r9)#
 r8=&\1
 r8=(r8)#
 r8=r8+r9
 r0=(r8)$
"
 data " \$(\#),"
 data " r7=r6
 r6=r5
 r5=r4
 r4=r3
 r3=r2
 r2=r1
 r1=r0
 r9=&\2
 r9=(r9)#
 r8=&\1
 r8=r8+r9
 r0=(r8)$
"
 data " (\)#(\#)="
 data " r9=&\2
 r9=(r9)#
 r9=r9+r9
 r9=r9+r9
 r8=&\1
 r8=(r8)#
 r8=r8+r9
 (r8)#=r0
"
 data " \#(\#)="
 data " r9=&\2
 r9=(r9)#
 r9=r9+r9
 r9=r9+r9
 r8=&\1
 r8=r8+r9
 (r8)#=r0
"
 data " (\)!(\#)="
 data " r9=&\2
 r9=(r9)#
 r9=r9+r9
 r9=r9+r9
 r8=&\1
 r8=(r8)#
 r8=r8+r9
 (r8)!=r0
"
 data " \!(\#)="
 data " r9=&\2
 r9=(r9)#
 r9=r9+r9
 r9=r9+r9
 r8=&\1
 r8=r8+r9
 (r8)!=r0
"
 data " (\)%(\#)="
 data " r9=&\2
 r9=(r9)#
 r9=r9+r9
 r8=&\1
 r8=(r8)#
 r8=r8+r9
 (r8)%=r0
"
 data " \%(\#)="
 data " r9=&\2
 r9=(r9)#
 r9=r9+r9
 r8=&\1
 r8=r8+r9
 (r8)%=r0
"
 data " (\)$(\#)="
 data " r9=&\2
 r9=(r9)#
 r8=&\1
 r8=(r8)#
 r8=r8+r9
 (r8)$=r0
"
 data " \$(\#)="
 data " r9=&\2
 r9=(r9)#
 r8=&\1
 r8=r8+r9
 (r8)$=r0
"
 data " (\)#(\),"
 data " r7=r6
 r6=r5
 r5=r4
 r4=r3
 r3=r2
 r2=r1
 r1=r0
 r9=&\2
 r9=r9+r9
 r9=r9+r9
 r8=&\1
 r8=(r8)#
 r8=r8+r9
 r0=(r8)#
"
 data " \#(\),"
 data " r7=r6
 r6=r5
 r5=r4
 r4=r3
 r3=r2
 r2=r1
 r1=r0
 r9=&\2
 r9=r9+r9
 r9=r9+r9
 r8=&\1
 r8=r8+r9
 r0=(r8)#
"
 data " (\)!(\),"
 data " r7=r6
 r6=r5
 r5=r4
 r4=r3
 r3=r2
 r2=r1
 r1=r0
 r9=&\2
 r9=r9+r9
 r9=r9+r9
 r8=&\1
 r8=(r8)#
 r8=r8+r9
 r0=(r8)!
"
 data " \!(\),"
 data " r7=r6
 r6=r5
 r5=r4
 r4=r3
 r3=r2
 r2=r1
 r1=r0
 r9=&\2
 r9=r9+r9
 r9=r9+r9
 r8=&\1
 r8=r8+r9
 r0=(r8)!
"
 data " (\)%(\),"
 data " r7=r6
 r6=r5
 r5=r4
 r4=r3
 r3=r2
 r2=r1
 r1=r0
 r9=&\2
 r9=r9+r9
 r8=&\1
 r8=(r8)#
 r8=r8+r9
 r0=(r8)%
"
 data " \%(\),"
 data " r7=r6
 r6=r5
 r5=r4
 r4=r3
 r3=r2
 r2=r1
 r1=r0
 r9=&\2
 r9=r9+r9
 r8=&\1
 r8=r8+r9
 r0=(r8)%
"
 data " (\)$(\),"
 data " r7=r6
 r6=r5
 r5=r4
 r4=r3
 r3=r2
 r2=r1
 r1=r0
 r9=&\2
 r8=&\1
 r8=(r8)#
 r8=r8+r9
 r0=(r8)$
"
 data " \$(\),"
 data " r7=r6
 r6=r5
 r5=r4
 r4=r3
 r3=r2
 r2=r1
 r1=r0
 r9=&\2
 r8=&\1
 r8=r8+r9
 r0=(r8)$
"
 data " (\)#(\)="
 data " r9=&\2
 r9=r9+r9
 r9=r9+r9
 r8=&\1
 r8=(r8)#
 r8=r8+r9
 (r8)#=r0
"
 data " \#(\)="
 data " r9=&\2
 r9=r9+r9
 r9=r9+r9
 r8=&\1
 r8=r8+r9
 (r8)#=r0
"
 data " (\)!(\)="
 data " r9=&\2
 r9=r9+r9
 r9=r9+r9
 r8=&\1
 r8=(r8)#
 r8=r8+r9
 (r8)!=r0
"
 data " \!(\)="
 data " r9=&\2
 r9=r9+r9
 r9=r9+r9
 r8=&\1
 r8=r8+r9
 (r8)!=r0
"
 data " (\)%(\)="
 data " r9=&\2
 r9=r9+r9
 r8=&\1
 r8=(r8)#
 r8=r8+r9
 (r8)%=r0
"
 data " \%(\)="
 data " r9=&\2
 r9=r9+r9
 r8=&\1
 r8=r8+r9
 (r8)%=r0
"
 data " (\)$(\)="
 data " r9=&\2
 r8=&\1
 r8=(r8)#
 r8=r8+r9
 (r8)$=r0
"
 data " \$(\)="
 data " r9=&\2
 r8=&\1
 r8=r8+r9
 (r8)$=r0
"
 data " \#++"
 data " r8=&\1
 r9=(r8)#
 r9=r9+1
 (r8)#=r9
"
 data " \#--"
 data " r8=&\1
 r9=(r8)#
 r9=r9-1
 (r8)#=r9
"
 data " \!++"
 data " r8=&\1
 r9=(r8)!
 r9=r9+1
 (r8)!=r9
"
 data " \!--"
 data " r8=&\1
 r9=(r8)!
 r9=r9-1
 (r8)!=r9
"
 data " \%++"
 data " r8=&\1
 r9=(r8)%
 r9=r9+1
 (r8)%=r9
"
 data " \%--"
 data " r8=&\1
 r9=(r8)%
 r9=r9-1
 (r8)%=r9
"
 data " \$++"
 data " r8=&\1
 r9=(r8)$
 r9=r9+1
 (r8)$=r9
"
 data " \$--"
 data " r8=&\1
 r9=(r8)$
 r9=r9-1
 (r8)$=r9
"
 data " (\)#,"
 data " r7=r6
 r6=r5
 r5=r4
 r4=r3
 r3=r2
 r2=r1
 r1=r0
 r8=&\1
 r8=(r8)#
 r0=(r8)#
"
 data " \#,"
 data " r7=r6
 r6=r5
 r5=r4
 r4=r3
 r3=r2
 r2=r1
 r1=r0
 r8=&\1
 r0=(r8)#
"
 data " (\)!,"
 data " r7=r6
 r6=r5
 r5=r4
 r4=r3
 r3=r2
 r2=r1
 r1=r0
 r8=&\1
 r8=(r8)#
 r0=(r8)!
"
 data " \!,"
 data " r7=r6
 r6=r5
 r5=r4
 r4=r3
 r3=r2
 r2=r1
 r1=r0
 r8=&\1
 r0=(r8)!
"
 data " (\)%,"
 data " r7=r6
 r6=r5
 r5=r4
 r4=r3
 r3=r2
 r2=r1
 r1=r0
 r8=&\1
 r8=(r8)#
 r0=(r8)%
"
 data " \%,"
 data " r7=r6
 r6=r5
 r5=r4
 r4=r3
 r3=r2
 r2=r1
 r1=r0
 r8=&\1
 r0=(r8)%
"
 data " (\)$,"
 data " r7=r6
 r6=r5
 r5=r4
 r4=r3
 r3=r2
 r2=r1
 r1=r0
 r8=&\1
 r8=(r8)#
 r0=(r8)$
"
 data " \$,"
 data " r7=r6
 r6=r5
 r5=r4
 r4=r3
 r3=r2
 r2=r1
 r1=r0
 r8=&\1
 r0=(r8)$
"
 data " \,"
 data " r7=r6
 r6=r5
 r5=r4
 r4=r3
 r3=r2
 r2=r1
 r1=r0
 r0=&\1
"
 data " (\)#="
 data " r8=&\1
 r8=(r8)#
 (r8)#=r0
"
 data " \#="
 data " r8=&\1
 (r8)#=r0
"
 data " (\)!="
 data " r8=&\1
 r8=(r8)#
 (r8)!=r0
"
 data " \!="
 data " r8=&\1
 (r8)!=r0
"
 data " (\)%="
 data " r8=&\1
 r8=(r8)#
 (r8)%=r0
"
 data " \%="
 data " r8=&\1
 (r8)%=r0
"
 data " (\)$="
 data " r8=&\1
 r8=(r8)#
 (r8)$=r0
"
 data " \$="
 data " r8=&\1
 (r8)$=r0
"
 data " data\"
 data " long \1
"
 data " @\(\)"
 data " r10=&\2
 r8=&\1
 r8=(r8)#
 lr=&$+24
 sp=sp-4
 (sp)#=lr
 pc=r8
"
 data " @\"
 data " r8=&\1
 r8=(r8)#
 lr=&$+24
 sp=sp-4
 (sp)#=lr
 pc=r8
"
 data " \"
 data " r8=&\1
 lr=&$+24
 sp=sp-4
 (sp)#=lr
 pc=r8
"

 data NULL

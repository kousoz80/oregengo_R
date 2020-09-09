// oregengo-R for ARM CPU コードジェネレータ定義データ
char* codegen[] = {
"/\\/", "\\1\n",
" \\:", "\\1:\n",
"\\:", "\\1:\n",
" jge \\", " r1-r0\n jge \\1\n",
" jlt \\", " r1-r0\n jlt \\1\n",
" jz \\", " r1-r0\n jz \\1\n",
" jnz \\", " r1-r0\n jnz \\1\n",
" jmp \\", " jmp \\1\n",
" goto\\", " jmp \\1\n",
" +", " r0=r0+r1\n",
" -", " r0=r1-r0\n",
" *", " r0=r1*r0\n",
" /", " lr=pc+20\n sp=sp-4\n (sp)=lr\n r8=&idiv\n pc=r8\n",
" neg", " r8=0\n r0=r8-r0\n",
" not", " r8=&0xffffffff\n r0=r0^r8\n",
" mod", " lr=pc+20\n sp=sp-4\n (sp)=lr\n r8=&mod\n pc=r8\n",
" swap", " r8=r0\n r0=r1\n r1=r8\n",
" push", " r7=r6\n r6=r5\n r5=r4\n r4=r3\n r3=r2\n r2=r1\n r1=r0\n",
" pop", " r0=r1\n r1=r2\n r2=r3\n r3=r4\n r4=r5\n r5=r6\n r6=r7\n",
" PUSH", " sp=sp-4\n (sp)=r0\n",
" POP", " r0=(sp)\n sp=sp+4\n",
" umul", " r0=r0*r1\n",
" udiv", " lr=pc+20\n sp=sp-4\n (sp)=lr\n r8=&udiv\n pc=r8\n",
" and", " r0=r0&r1\n",
" or", " r0=r0|r1\n",
" xor", " r0=r0^r1\n",
" getchar$,", " lr=pc+20\n sp=sp-4\n (sp)=lr\n r8=&getchar\n pc=r8\n",
" inkey$,", " lr=pc+20\n sp=sp-4\n (sp)=lr\n r8=&inkey\n pc=r8\n",
" end", " lr=(sp)#\n sp=sp+4\n ret\n",
" return", " lr=(sp)#\n sp=sp+4\n ret\n",
" jmp@", " pc=r0\n",
" call@", " lr=pc+8\n sp=sp-4\n (sp)#=lr\n pc=r0\n",
" ->\\#=", " r8=&\\1\n r8=r8+r0\n r9=r1\n (r8)#=r9\n",
" ->\\!=", " r8=&\\1\n r8=r8+r0\n r9=r1\n (r8)!=r9\n",
" ->\\%=", " r8=&\\1\n r8=r8+r0\n r9=r1\n (r8)%=r9\n",
" ->\\$=", " r8=&\\1\n r8=r8+r0\n r9=r1\n (r8)$=r9\n",
" ->\\#", " r8=&\\1\n r8=r8+r0\n r0=(r8)#\n",
" ->\\!", " r8=&\\1\n r8=r8+r0\n r0=(r8)!\n",
" ->\\%", " r8=&\\1\n r8=r8+r0\n r0=(r8)%\n",
" ->\\$", " r8=&\\1\n r8=r8+r0\n r0=(r8)$\n",
" ->@\\(\\)", " r10=&\\2\n r8=&\\1\n r8=r8+r0\n r8=(r8)#\n lr=pc+8\n sp=sp-4\n (sp)=lr\n pc=r8\n",
" ->@\\", " r8=&\\1\n r8=r8+r0\n r8=(r8)#\n lr=pc+8\n sp=sp-4\n (sp)=lr\n pc=r8\n",
" ->\\", " r8=&\\1\n r0=r0+r8\n",
" (\\)#(\\#),", " r7=r6\n r6=r5\n r5=r4\n r4=r3\n r3=r2\n r2=r1\n r1=r0\n r9=&\\2\n r9=(r9)#\n r9=r9+r9\n r9=r9+r9\n r8=&\\1\n r8=(r8)#\n r8=r8+r9\n r0=(r8)#\n",
" \\#(\\#),", " r7=r6\n r6=r5\n r5=r4\n r4=r3\n r3=r2\n r2=r1\n r1=r0\n r9=&\\2\n r9=(r9)#\n r9=r9+r9\n r9=r9+r9\n r8=&\\1\n r8=r8+r9\n r0=(r8)#\n",
" (\\)!(\\#),", " r7=r6\n r6=r5\n r5=r4\n r4=r3\n r3=r2\n r2=r1\n r1=r0\n r9=&\\2\n r9=(r9)#\n r9=r9+r9\n r9=r9+r9\n r8=&\\1\n r8=(r8)#\n r8=r8+r9\n r0=(r8)!\n",
" \\!(\\#),", " r7=r6\n r6=r5\n r5=r4\n r4=r3\n r3=r2\n r2=r1\n r1=r0\n r9=&\\2\n r9=(r9)#\n r9=r9+r9\n r9=r9+r9\n r8=&\\1\n r8=r8+r9\n r0=(r8)!\n",
" (\\)%(\\#),", " r7=r6\n r6=r5\n r5=r4\n r4=r3\n r3=r2\n r2=r1\n r1=r0\n r9=&\\2\n r9=(r9)#\n r9=r9+r9\n r8=&\\1\n r8=(r8)#\n r8=r8+r9\n r0=(r8)%\n",
" \\%(\\#),", " r7=r6\n r6=r5\n r5=r4\n r4=r3\n r3=r2\n r2=r1\n r1=r0\n r9=&\\2\n r9=(r9)#\n r9=r9+r9\n r8=&\\1\n r8=r8+r9\n r0=(r8)%\n",
" (\\)$(\\#),", " r7=r6\n r6=r5\n r5=r4\n r4=r3\n r3=r2\n r2=r1\n r1=r0\n r9=&\\2\n r9=(r9)#\n r8=&\\1\n r8=(r8)#\n r8=r8+r9\n r0=(r8)$\n",
" \\$(\\#),", " r7=r6\n r6=r5\n r5=r4\n r4=r3\n r3=r2\n r2=r1\n r1=r0\n r9=&\\2\n r9=(r9)#\n r8=&\\1\n r8=r8+r9\n r0=(r8)$\n",
" (\\)#(\\#)=", " r9=&\\2\n r9=(r9)#\n r9=r9+r9\n r9=r9+r9\n r8=&\\1\n r8=(r8)#\n r8=r8+r9\n (r8)#=r0\n",
" \\#(\\#)=", " r9=&\\2\n r9=(r9)#\n r9=r9+r9\n r9=r9+r9\n r8=&\\1\n r8=r8+r9\n (r8)#=r0\n",
" (\\)!(\\#)=", " r9=&\\2\n r9=(r9)#\n r9=r9+r9\n r9=r9+r9\n r8=&\\1\n r8=(r8)#\n r8=r8+r9\n (r8)!=r0\n",
" \\!(\\#)=", " r9=&\\2\n r9=(r9)#\n r9=r9+r9\n r9=r9+r9\n r8=&\\1\n r8=r8+r9\n (r8)!=r0\n",
" (\\)%(\\#)=", " r9=&\\2\n r9=(r9)#\n r9=r9+r9\n r8=&\\1\n r8=(r8)#\n r8=r8+r9\n (r8)%=r0\n",
" \\%(\\#)=", " r9=&\\2\n r9=(r9)#\n r9=r9+r9\n r8=&\\1\n r8=r8+r9\n (r8)%=r0\n",
" (\\)$(\\#)=", " r9=&\\2\n r9=(r9)#\n r8=&\\1\n r8=(r8)#\n r8=r8+r9\n (r8)$=r0\n",
" \\$(\\#)=", " r9=&\\2\n r9=(r9)#\n r8=&\\1\n r8=r8+r9\n (r8)$=r0\n",
" (\\)#(\\),", " r7=r6\n r6=r5\n r5=r4\n r4=r3\n r3=r2\n r2=r1\n r1=r0\n r9=&\\2\n r9=r9+r9\n r9=r9+r9\n r8=&\\1\n r8=(r8)#\n r8=r8+r9\n r0=(r8)#\n",
" \\#(\\),", " r7=r6\n r6=r5\n r5=r4\n r4=r3\n r3=r2\n r2=r1\n r1=r0\n r9=&\\2\n r9=r9+r9\n r9=r9+r9\n r8=&\\1\n r8=r8+r9\n r0=(r8)#\n",
" (\\)!(\\),", " r7=r6\n r6=r5\n r5=r4\n r4=r3\n r3=r2\n r2=r1\n r1=r0\n r9=&\\2\n r9=r9+r9\n r9=r9+r9\n r8=&\\1\n r8=(r8)#\n r8=r8+r9\n r0=(r8)!\n",
" \\!(\\),", " r7=r6\n r6=r5\n r5=r4\n r4=r3\n r3=r2\n r2=r1\n r1=r0\n r9=&\\2\n r9=r9+r9\n r9=r9+r9\n r8=&\\1\n r8=r8+r9\n r0=(r8)!\n",
" (\\)%(\\),", " r7=r6\n r6=r5\n r5=r4\n r4=r3\n r3=r2\n r2=r1\n r1=r0\n r9=&\\2\n r9=r9+r9\n r8=&\\1\n r8=(r8)#\n r8=r8+r9\n r0=(r8)%\n",
" \\%(\\),", " r7=r6\n r6=r5\n r5=r4\n r4=r3\n r3=r2\n r2=r1\n r1=r0\n r9=&\\2\n r9=r9+r9\n r8=&\\1\n r8=r8+r9\n r0=(r8)%\n",
" (\\)$(\\),", " r7=r6\n r6=r5\n r5=r4\n r4=r3\n r3=r2\n r2=r1\n r1=r0\n r9=&\\2\n r8=&\\1\n r8=(r8)#\n r8=r8+r9\n r0=(r8)$\n",
" \\$(\\),", " r7=r6\n r6=r5\n r5=r4\n r4=r3\n r3=r2\n r2=r1\n r1=r0\n r9=&\\2\n r8=&\\1\n r8=r8+r9\n r0=(r8)$\n",
" (\\)#(\\)=", " r9=&\\2\n r9=r9+r9\n r9=r9+r9\n r8=&\\1\n r8=(r8)#\n r8=r8+r9\n (r8)#=r0\n",
" \\#(\\)=", " r9=&\\2\n r9=r9+r9\n r9=r9+r9\n r8=&\\1\n r8=r8+r9\n (r8)#=r0\n",
" (\\)!(\\)=", " r9=&\\2\n r9=r9+r9\n r9=r9+r9\n r8=&\\1\n r8=(r8)#\n r8=r8+r9\n (r8)!=r0\n",
" \\!(\\)=", " r9=&\\2\n r9=r9+r9\n r9=r9+r9\n r8=&\\1\n r8=r8+r9\n (r8)!=r0\n",
" (\\)%(\\)=", " r9=&\\2\n r9=r9+r9\n r8=&\\1\n r8=(r8)#\n r8=r8+r9\n (r8)%=r0\n",
" \\%(\\)=", " r9=&\\2\n r9=r9+r9\n r8=&\\1\n r8=r8+r9\n (r8)%=r0\n",
" (\\)$(\\)=", " r9=&\\2\n r8=&\\1\n r8=(r8)#\n r8=r8+r9\n (r8)$=r0\n",
" \\$(\\)=", " r9=&\\2\n r8=&\\1\n r8=r8+r9\n (r8)$=r0\n",
" \\#++", " r8=&\\1\n r9=(r8)#\n r9=r9+1\n (r8)#=r9\n",
" \\#--", " r8=&\\1\n r9=(r8)#\n r9=r9-1\n (r8)#=r9\n",
" \\!++", " r8=&\\1\n r9=(r8)!\n r9=r9+1\n (r8)!=r9\n",
" \\!--", " r8=&\\1\n r9=(r8)!\n r9=r9-1\n (r8)!=r9\n",
" \\%++", " r8=&\\1\n r9=(r8)%\n r9=r9+1\n (r8)%=r9\n",
" \\%--", " r8=&\\1\n r9=(r8)%\n r9=r9-1\n (r8)%=r9\n",
" \\$++", " r8=&\\1\n r9=(r8)$\n r9=r9+1\n (r8)$=r9\n",
" \\$--", " r8=&\\1\n r9=(r8)$\n r9=r9-1\n (r8)$=r9\n",
" (\\)#,", " r7=r6\n r6=r5\n r5=r4\n r4=r3\n r3=r2\n r2=r1\n r1=r0\n r8=&\\1\n r8=(r8)#\n r0=(r8)#\n",
" \\#,", " r7=r6\n r6=r5\n r5=r4\n r4=r3\n r3=r2\n r2=r1\n r1=r0\n r8=&\\1\n r0=(r8)#\n",
" (\\)!,", " r7=r6\n r6=r5\n r5=r4\n r4=r3\n r3=r2\n r2=r1\n r1=r0\n r8=&\\1\n r8=(r8)#\n r0=(r8)!\n",
" \\!,", " r7=r6\n r6=r5\n r5=r4\n r4=r3\n r3=r2\n r2=r1\n r1=r0\n r8=&\\1\n r0=(r8)!\n",
" (\\)%,", " r7=r6\n r6=r5\n r5=r4\n r4=r3\n r3=r2\n r2=r1\n r1=r0\n r8=&\\1\n r8=(r8)#\n r0=(r8)%\n",
" \\%,", " r7=r6\n r6=r5\n r5=r4\n r4=r3\n r3=r2\n r2=r1\n r1=r0\n r8=&\\1\n r0=(r8)%\n",
" (\\)$,", " r7=r6\n r6=r5\n r5=r4\n r4=r3\n r3=r2\n r2=r1\n r1=r0\n r8=&\\1\n r8=(r8)#\n r0=(r8)$\n",
" \\$,", " r7=r6\n r6=r5\n r5=r4\n r4=r3\n r3=r2\n r2=r1\n r1=r0\n r8=&\\1\n r0=(r8)$\n",
" \\,", " r7=r6\n r6=r5\n r5=r4\n r4=r3\n r3=r2\n r2=r1\n r1=r0\n r0=&\\1\n",
" (\\)#=", " r8=&\\1\n r8=(r8)#\n (r8)#=r0\n",
" \\#=", " r8=&\\1\n (r8)#=r0\n",
" (\\)!=", " r8=&\\1\n r8=(r8)#\n (r8)!=r0\n",
" \\!=", " r8=&\\1\n (r8)!=r0\n",
" (\\)%=", " r8=&\\1\n r8=(r8)#\n (r8)%=r0\n",
" \\%=", " r8=&\\1\n (r8)%=r0\n",
" (\\)$=", " r8=&\\1\n r8=(r8)#\n (r8)$=r0\n",
" \\$=", " r8=&\\1\n (r8)$=r0\n",
" data\\", " long \\1\n",
" @\\(\\)", " r10=&\\2\n r8=&\\1\n r8=(r8)#\n lr=pc+8\n sp=sp-4\n (sp)=lr\n pc=r8\n",
" @\\", " r8=&\\1\n r8=(r8)#\n lr=pc+8\n sp=sp-4\n (sp)=lr\n pc=r8\n",
" \\", " r8=&\\1\n lr=pc+8\n sp=sp-4\n (sp)=lr\n pc=r8\n",

NULL
};

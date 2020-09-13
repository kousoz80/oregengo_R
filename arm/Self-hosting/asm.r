// asm ARMアセンブラ for android OS ver 0.1

main:

// const EFI_IMAGE_BASE 22
// const EFI_IMAGE_SIZE  52
// const EFI_PROG_ADDR 42
   const ELF_MEM_SIZE 17
   const ELF_FILE_SIZE 18
 
 char    buf$(256),xbuf$(256),infile$(FILE_SIZE),outfile$(FILE_SIZE)
 long    in_fname#,out_fname#,start_adrs#,blist#,prev_loc#
 count  i#,j#,nn#
 long    cmnt1#,cmnt2#,pc#,ofset#
 long    image_size#

 // ファイル名・オプション設定
 NULL,  in_fname#= out_fname#=
 0x8054, start_adrs#=
 0, blist#=
 if (argc)#<2 then " command input error", prints nl end
 (argc)#, 1, - nn#=
 for i#=1 to nn#
   (argv)#(i#), buf, strcpy
   buf, xbuf, strcpy

   // リストオプションの設定
   NULL, buf+5$=
   buf, "-list", strcmp j#=
   if j#=0 then  1, blist#= gotoset_fname1

   // スタートアドレスの設定
   NULL, buf+4$=
   buf, "-p0x", strcmp j#=
   if j#=0 then  xbuf+4, 16, atoi start_adrs#= gotoset_fname1

   // ファイルネームの設定
   if in_fname#=NULL then argv-8#(i#), in_fname#= gotoset_fname1
   argv-8#(i#), out_fname#= 
   set_fname1:
 next i#

 if in_fname#=NULL then " command input error", prints nl end
 if out_fname#=NULL then "a.efi", out_fname#=

 // 各パラメータを読み込む
 paramater, restore
 read cmnt1#= read cmnt2#= read pc#= read ofset#=
 symbols,   restore
 0, symbl_p#=
 loop_init:
  read i#=
  if i#=NULL goto exit_init
  read j#=  read symbl_type$=
  i#, j#, def_symbl
  goto loop_init
 exit_init:

 // pass1: ラベルの定義
 1, pass#= 0, line#=
 start_adrs#, location#=
 in_fname#, infile,  ropen j#=
 if j#=ERROR then "file not found", prints nl end
 loop_pass1:
  buf, infile, finputs j#=
  if j#=EOF goto exit_pass1
  buf, xbuf, strcpy
  asm_1line
  if (lbl)$=NULL goto loop_pass1
   lbl#, lbl_serch
   if ex$=NULL  then LABEL, symbl_type$= lbl#, address#, def_symbl gotoloop_pass1
    line#, printd " mulsymbol: ", prints xbuf, prints nl
  goto loop_pass1
 exit_pass1:
 infile, rclose

// EFIヘッダにプログラム情報を書き込む
// start_adrs#, 0xffffffffff000000, and i#=
// start_adrs#, 0xffffff, and j#=
// i#, header#(EFI_IMAGE_BASE)=
// j#, header!(EFI_PROG_ADDR)=
// location#, start_adrs#, - image_size#= i#=
// image_size#, 4096, / 4096, * image_size#=
// if image_size#<i# then image_size#, 4096, + image_size#=
// image_size#, header!(EFI_IMAGE_SIZE)=
 
// ELF ヘッダにメモリサイズ・ファイルサイズを書き込む 
 location#, start_adrs#, - header!(ELF_MEM_SIZE)= header!(ELF_FILE_SIZE)=
  
 // pass2: コードの生成
 2, pass#= 0, line#=
 start_adrs#, location#=
 in_fname#,   infile,   ropen
 out_fname#, outfile, wopen

 // ヘッダを出力
 for i#=1 to HEADER_SIZE
   header-1$(i#),  outfile, putc
 next i#

 loop_pass2:
  buf, infile, finputs j#=
  if j#=EOF goto exit_pass2
  buf, xbuf, strcpy
  asm_1line j#=
  if j#<>ERROR goto no_error
    line#, printd " error: ", prints xbuf, prints nl
  no_error:

  // 命令タイプごとの処理
  case_NORMAL:
     if ins_type#<>NORMAL goto case_MEMORY
     if wordlen#<1 goto case_MEMORY
     for i#=1 to wordlen#
       ins-1$(i#),  outfile, putc
     next i#
     // リスト出力モード
     if blist#=0 goto case_MEMORY
     address#, hex prints ":", prints
     for i#=1 to wordlen#
       ins-1$(i#),  hex prints " ", prints
     next i#
     for i#=wordlen# to MAX_WORD
       "   ", prints
     next i#
     xbuf, prints nl

  case_MEMORY:
     if ins_type#<>MEMORY goto case_ALIGN
     location#, prev_loc#, - j#=
     if j#<1 goto memory1
       for i#=1 to j#
         0,  outfile, putc
       next i#
     memory1:
     // リスト出力モード
     if blist#=0 goto case_ALIGN
     address#, hex prints ": alloc ", prints
     j#, printd " bytes.            ", prints 
     xbuf, prints nl

  case_ALIGN:
     if ins_type#<>ALIGN goto default
     location#, prev_loc#, - j#=
     if j#<1 goto align1
       for i#=1 to j#
         0,  outfile, putc
       next i#
     align1:
     // リスト出力モード
     if blist#=0 goto default
     address#, hex prints ": skip ", prints
     j#, printd " bytes.", prints nl 

  default:
  goto loop_pass2
 exit_pass2:
 infile,  rclose
 outfile, wclose
 end


// 1行アセンブル
asm_1line:
 const NORMAL  0
 const ORG         1
 const EQU         2
 const MEMORY  3
 const ALIGN      4
 const EQU_PP   5
 const LABEL      0
 const MAX_WORD 64
 const END      -1

 count k#
 char  ins$(MAX_WORD),field$(MAX_WORD),arg$(256)
 long  location#,ins_type#,wordlen#,address#,line#,pass#
 long  lbl#,stt#,ref#,sou#,start_adr#,end_adr#,last_equ#

 line#, 1, + line#=
 location#, address#=
  0, wordlen#=  
 -1, ins_type#=

// コメントを除去する 
 buf, cmnt1, strstr k#=
 if k#<>NULL then NULL, (k)$=
 buf, cmnt2, strstr k#=
 if k#<>NULL then NULL, (k)$=

// 不要なスペースを除去する
 buf, strlen buf, + k#=
 del_space:
  if k#=buf goto normal_end
  k#, 1, - k#=
 if (k)$=SPACE goto del_space
 NULL, (k)$(1)=

// ラベルを分離する
ext_label:
 buf, lbl#= stt#=
 loop1:
  if  (stt)$=':'   goto exit1
  if  (stt)$=SPACE goto exit1
  if  (stt)$=NULL  goto normal_end
  stt#, 1, + stt#=
  goto loop1
 exit1:
 NULL, (stt)$=

// ステートメントを分離する
ext_statement:
 stt#, 1, + stt#=
 if  (stt)$=SPACE goto ext_statement
 if  (stt)$=NULL  goto normal_end

// 命令定義データを読み込む
 def_ins, restore
 read_ref:
  read ref#=  // 命令パターンを読み込む
  if  ref#=NULL goto error_end  // 読み込むデータが無ければエラー
  read ins_type#= read wordlen#=
  stt#, sou#=

 // 命令コードを読み込む
  0, k#=
  read_ins:
   if k#>=wordlen# goto clear_field
   read ins$(k#)= k#, 1, + k#=
  goto read_ins

 // ビットフィールドのクリア
  clear_field:
   for k#=0 to MAX_WORD
    0, field$(k#)=
   next k#
   0, d_bit_adr#=

  // パターンの比較
  cmp_a_char: // 1文字ごとに比較する
   if (ref)$<>NULL goto case_SPACE
   if (sou)$<>NULL goto fault_cmp
   goto success_cmp

   // スペース
   case_SPACE:
    if (ref)$<>SPACE goto case_YEN
    if (sou)$<>SPACE goto fault_cmp
    loop2:
     sou#, 1, + sou#=
     if (sou)$=SPACE goto loop2
     if (sou)$=NULL  goto fault_cmp
     ref#, 1, + ref#=
     goto cmp_a_char

   // \xxyy : 引数が存在する xx:タイプﾟ yy:ビットフィールドの幅
   case_YEN:
    long arg_type#

    if (ref)$<>'\' goto otherwise 
    (ref)$(1),     '0', - 10, *
    (ref)$(2), + '0', - arg_type#= // 引数のタイプ
    (ref)$(3),     '0', - 10, *
    (ref)$(4), + '0', - field_size#= // ビットフィールドの幅
    ref#, 5, + ref#=
    arg, k#=

    // 引数を分離する
    ext_arg:
     if (sou)$=NULL then if (ref)$<>NULL goto fault_cmp
     if (sou)$=(ref)$ then NULL, (k)$= gotoeval_arg
     (sou)$, (k)$=
     sou#, 1, + sou#=
     k#,   1, + k#=
     goto ext_arg

    // 引数を評価する
    eval_arg:
     long value#

     if arg$=NULL   goto fault_cmp
     if arg_type#<8 goto normal_form

     // アセンブラ固有のシンボル(レジスタ等)として評価する
     implied_symbol:
      arg, arg_type#, symbl_serch value#=
      if ex$=NULL goto fault_cmp
      goto set_field

      // 通常の数式として評価する
     normal_form:
      const A_QUOT 39
      char  op1$,op2$
      long  num#,p#,v#

      '+', op1$=
      arg, num#= p#=
      0, value#=
      if arg_type#<4 then 0, value#= gotoserch_op
      if arg_type#<6 then ofset#, location#, - wordlen#, - value#=

      // 演算子を探す
      serch_op:
       (p)$, op2$= p#++
       if op2$='+'    goto number2
       if op2$='-'     goto number2
       if op2$='*'     goto number2
       if op2$='/'      goto number2
       if op2$=NULL goto number1
       goto serch_op

      number1:
       if (num)$=NULL goto fault_cmp

      number2:
       NULL, (p)$(-1)=  0, v#=
       if (num)$=NULL goto serch_next

       // 先頭が "\'" 
       if (num)$=A_QUOT then (num)$(1), v#= gotoserch_next

       // 先頭が"0"
       if (num)$<>'0' goto decimal
       if (num)$(1)='b' then num#, 2, + 2,   atoi v#= gotoserch_next // 2進数
       if (num)$(1)='x' then num#, 2, + 16, atoi v#= gotoserch_next // 16進数
       num#, 1, +  8,  atoi v#= gotoserch_next // 8進数

       // 10進数
       decimal:
        if (num)$<'0' goto label
        if (num)$>'9' goto label
        num#, 10, atoi v#=
        goto serch_next
       
       // ラベル
       label:
        num#, pc#, strcmp k#=
         if k#=0 then location#, v#= gotoserch_next
        num#, lbl_serch v#=
         if ex$=NULL then if pass#=2 goto fault_cmp

      serch_next:
       if op1$='+' then value#, v#, + value#=
       if op1$='-'  then value#, v#,  - value#=
       if op1$='*'  then value#, v#,  * value#=
       if op1$='/'   then value#, v#,  / value#=
       if op2$<>NULL then op2$, op1$= p#, num#= gotoserch_op

    // 引数の値をビット列に変換する
    set_field:
     0, s_bit_adr#=
     value, field, bit_copy  k#=
     if k#=ERROR   then if pass#=2 goto fault_cmp
     goto cmp_a_char

   // その他の文字
   otherwise:
    if (ref)$<>(sou)$ goto fault_cmp
    ref#, 1, + ref#=
    sou#, 1, + sou#=
    goto cmp_a_char

  // パターン比較が失敗したときの処理
  fault_cmp:
   read k#=
   if k#<>END goto fault_cmp
   goto read_ref

  // パターン比較が成功したときの処理
  success_cmp:
   0, s_bit_adr#=
   create_ins:  // 命令コードを展開
    read field_size#=
    if field_size#=END goto normal_end
    read d_bit_adr#=
    field, ins, bit_copy
    goto create_ins

 // エラー発生
 error_end:
  ERROR,
  goto exit_asm

 // 正常終了
 normal_end:
  NULL,

 exit_asm:
  k#=

  if ins_type#=EQU       then value#, address#= last_equ#=
  if ins_type#=EQU_PP then last_equ#, address#= value#, last_equ#, + last_equ#=
  if ins_type#=ORG       then value#, location#= address#=

  if  ins_type#<>NORMAL goto not_NORMAL
    location#, prev_loc#= address#=
    location#, wordlen#, + location#=
  not_NORMAL:

  if  ins_type#<>MEMORY goto not_MEMORY
    location#, prev_loc#= address#=
    location#, value#, + location#=
  not_MEMORY:

  if  ins_type#<>ALIGN goto not_ALIGN
    location#, prev_loc#=
    location#, value#, / value#, * location#=
    if location#<prev_loc# then location#, value#, + location#=
    location#, address#=
  not_ALIGN:

  k#, end

// ビット列をコピーする
bit_copy:
 count x#,y#,z#
 long field_size#,s_bit_adr#,d_bit_adr#,s#,d#

 d#= swap s#=
 if field_size#<=0 then NULL, end
  for x#=1 to field_size#
   s_bit_adr#, 8, / y#=
   s_bit_adr#, 8, mod power2 (s)$(y#), and z#=
   d_bit_adr#, 8, / y#=
   if z#<>0 then d_bit_adr#, 8, mod power2 (d)$(y#), xor (d)$(y#)=
   s_bit_adr#, 1, + s_bit_adr#=
   d_bit_adr#, 1, + d_bit_adr#=
  next x#
  field_size#, 1, -   power2 y#=
  arg_type#,  1, and z#=
  if z#=0 then 0, y#, - x#=       y#,   1, - y#=
  if z#=1 then 0,       x#=    2, y#, * 1, - y#=
  if (s)#<x# then ERROR, end
  if (s)#>y# then ERROR, end
  NULL, end

// 2のべき乗を求める
power2:
/ r8=1/
/ r0=r8<<r0/
  end

// シンボルを定義する
 const LEN_SYMBOL 256
 const TYPE       0
 const VALUE      1
 const NAME       9
 const LIMIT      255

 char symbl_type$,ex$
 long  symbl_name#,symbl_p#
 char symbol$(1024000)

def_symbl:
 z#= swap x#=
 symbl_p#,    symbol+NAME, + x#, swap strcpy
 symbl_type$, symbol+TYPE$(symbl_p#)=
 z#,          symbol+VALUE#(symbl_p#)=
 NULL,        symbol+LIMIT$(symbl_p#)=
 symbl_p#,    LEN_SYMBOL, + symbl_p#=
 end

// ラベルの検索
lbl_serch:
 LABEL,

// シンボルの検索
symbl_serch:
 symbl_type$= swap symbl_name#=
 symbl_p#, LEN_SYMBOL, - y#=
 for x#=0 to y# step LEN_SYMBOL
  if symbol+TYPE$(x#)<>symbl_type$  goto not_match
   symbol+NAME,  x#, + symbl_name#, strcmp z#=
   if z#=0 then 1, ex$= symbol+VALUE#(x#), end
  not_match:
 next x#
 NULL, ex$=
 end

// データ領域
 .data

// ファイルヘッダ
 const HEADER_SIZE 84
header:
 data 0x464c457f,0x00010101,0x00000000,0x00000000 
 data 0x00280002,0x00000001,0x00008054,0x00000034 
 data 0x00000160,0x05000000,0x00200034,0x00280001 
 data 0x00030006,0x00000001,0x00000000,0x00008000 
 data 0x00008000,0x00000110,0x00000110,0x00000005 
 data 0x00008000
 
// アセンブラデータ
paramater:
  data "/*","//","$",-8

// レジスタの定義データ
symbols:
 data "r0",0,17
 data "r1",1,17
 data "r2",2,17
 data "r3",3,17
 data "r4",4,17
 data "r5",5,17
 data "r6",6,17
 data "r7",7,17
 data "r8",8,17
 data "r9",9,17
 data "r10",10,17
 data "r11",11,17
 data "r12",12,17
 data "r13",13,17
 data "r14",14,17
 data "r15",15,17
 data "a1",0,17
 data "a2",1,17
 data "a3",2,17
 data "a4",3,17
 data "v1",4,17
 data "v2",5,17
 data "v3",6,17
 data "v4",7,17
 data "v5",8,17
 data "v6",9,17
 data "v7",10,17
 data "v8",11,17
 data "ip",12,17
 data "sp",13,17
 data "lr",14,17
 data "pc",15,17
 data "wr",7,17
 data "sb",9,17
 data "sl",10,17
 data "fp",11,17
 data NULL

// 命令定義データ
def_ins:
 data "org \0632",ORG,0
 data END
 data "equ \0632",EQU,0
 data END
 data "= \0632",EQU,0
 data END
 data "+= \0632",EQU_PP,0
 data END
 data "memory \0232",MEMORY,0
 data END
 data "align \0632",ALIGN,0
 data END
 data "byte \0632",NORMAL,1
 data 0
 data 8,0
 data END
 data "short \0632",NORMAL,2
 data 0,0
 data 16,0
 data END
 data "int \0632",NORMAL,4
 data 0,0,0,0
 data 32,0
 data END
 data "long \0632",NORMAL,4
 data 0,0,0,0
 data 32,0
 data END
 data "\\1704=\\1704+\\1704",NORMAL,4
 data 0x00,0x00,0x80,0xe0
 data 4,12,4,16,4,0
 data END
 data "\\1704=\\1704-\\1704",NORMAL,4
 data 0x00,0x00,0x40,0xe0
 data 4,12,4,16,4,0
 data END
 data "\\1704=\\1704&\\1704",NORMAL,4
 data 0x00,0x00,0x00,0xe0
 data 4,12,4,16,4,0
 data END
 data "\\1704=\\1704|\\1704",NORMAL,4
 data 0x00,0x00,0x80,0xe1
 data 4,12,4,16,4,0
 data END
 data "\\1704=\\1704^\\1704",NORMAL,4
 data 0x00,9x00,0x20,0xe0
 data  4,12,4,16,4,0
 data END
 data "\\1704=\\1704<<\\1704",NORMAL,4
 data 0x10,0x00,0xa0,0xe1
 data 4,12,4,0,4,8
 data END
 data "\\1704=\\1704>>\\1704",NORMAL,4
 data 0x30,0x00,0xa0,0xe1
 data 4,12,4,0,4,8
 data END
 data "\\1704=\\1704*\\1704",NORMAL,4
 data 0x90,0x00,0x00,0xe0
 data 4,16,4,0,4,8
 data END
 data "\\1704-\\1704",NORMAL,4
 data 0x00,0x00,0x50,0xe1
 data 4,16,4,0
 data END
 data "\\1704&\\1704",NORMAL,4
 data 0x00,0x00,0x10,0xe1
 data 4,16,4,0
 data END
 data "\\1704=\\1704+\\0708",NORMAL,4
 data 0x00,0x00,0x80,0xe2
 data 4,12,4,16,8,0
 data END
 data "\\1704=\\1704-\\0708",NORMAL,4
 data 0x00,0x00,0x40,0xe2
 data 4,12,4,16,8,0
 data END
 data "\\1704=\\1704&\\0708",NORMAL,4
 data 0x00,0x00,0x00,0xe2
 data 4,12,4,16,8,0
 data END
 data "\\1704=\\1704|\\0708",NORMAL,4
 data 0x00,0x00,0x80,0xe3
 data 4,12,4,16,8,0
 data END
 data "\\1704=\\1704^\\0708",NORMAL,4
 data 0x00,0x00,0x20,0xe2
 data 4,12,4,16,8,0
 data END
 data "\\1704=\\1704<<\\0705",NORMAL,4
 data 0x00,0x00,0xa0,0xe1
 data 4,12,4,0,5,7
 data END
 data "\\1704=\\1704>>\\0705",NORMAL,4
 data 0x20,0x00,0xa0,0xe1
 data 4,12,4,0,5,7
 data END
 data "\\1704-\\0708",NORMAL,4
 data 0x00,0x00,0x50,0xe3
 data 4,16,8,0
 data END
 data "\\1704&\\0708",NORMAL,4
 data 0x00,0x00,0x10,0xe3
 data 4,16,8,0
 data END
 data "\\1704=(\\1704+\\1704)#",NORMAL,4
 data 0x00,0x00,0x90,0xe7
 data 4,12,4,16,4,0
 data END
 data "\\1704=(\\1704+\\0708)#",NORMAL,4
 data 0x00,0x00,0x90,0xe5
 data 4,12,4,16,8,0
 data END
 data "\\1704=(\\1704)#",NORMAL,4
 data 0x00,0x00,0x90,0xe5
 data 4,12,4,16
 data END
 data "\\1704=(\\1704+\\1704)!",NORMAL,4
 data 0x00,0x00,0x90,0xe7
 data 4,12,4,16,4,0
 data END
 data "\\1704=(\\1704+\\0708)!",NORMAL,4
 data 0x00,0x00,0x90,0xe5
 data 4,12,4,16,8,0
 data END
 data "\\1704=(\\1704)!",NORMAL,4
 data 0x00,0x00,0x90,0xe5
 data 4,12,4,16
 data END
 data "\\1704=(\\1704+\\1704)%",NORMAL,4
 data 0x00,0x00,0x90,0xe1
 data 4,12,4,16,4,0
 data END
 data "\\1704=(\\1704+\\0708)%",NORMAL,4
 data 0x00,0x00,0xd0,0xe1
 data 4,12,4,16,8,0
 data END
 data "\\1704=(\\1704)%",NORMAL,4
 data 0x00,0x00,0xd0,0xe1
 data 4,12,4,16
 data END
 data "\\1704=(\\1704+\\1704)$",NORMAL,4
 data 0x00,0x00,0xd0,0xe7
 data 4,12,4,16,4,0
 data END
 data "\\1704=(\\1704+\\0708)$",NORMAL,4
 data 0x00,0x00,0xd0,0xe5
 data 4,12,4,16,8,0
 data END
 data "\\1704=(\\1704)$",NORMAL,4
 data 0x00,0x00,0xd0,0xe5
 data 4,12,4,16
 data END
 data "(\\1704+\\1704)#=\\1704",NORMAL,4
 data 0x00,0x00,0x80,0xe7
 data 4,16,4,0,4,12
 data END
 data "(\\1704+\\0708)#=\\1704",NORMAL,4
 data 0x00,0x00,0x80,0xe5
 data 4,16,8,0,4,12
 data END
 data "(\\1704)#=\\1704",NORMAL,4
 data 0x00,0x00,0x80,0xe5
 data 4,16,4,12
 data END
 data "(\\1704+\\1704)!=\\1704",NORMAL,4
 data 0x00,0x00,0x80,0xe7
 data 4,16,4,0,4,12
 data END
 data "(\\1704+\\0708)!=\\1704",NORMAL,4
 data 0x00,0x00,0x80,0xe5
 data 4,16,8,0,4,12
 data END
 data "(\\1704)!=\\1704",NORMAL,4
 data 0x00,0x00,0x80,0xe5
 data 4,16,4,12
 data END
 data "(\\1704+\\1704)%=\\1704",NORMAL,4
 data 0x00,0x00,0x80,0xe1
 data 4,16,4,0,4,12
 data END
 data "(\\1704+\\0708)%=\\1704",NORMAL,4
 data 0x00,0x00,0xc0,0xe1
 data 4,16,8,0,4,12
 data END
 data "(\\1704)%=\\1704",NORMAL,4
 data 0x00,0x00,0xc0,0xe1
 data 4,16,4,12
 data END
 data "(\\1704+\\1704)$=\\1704",NORMAL,4
 data 0x00,0x00,0xc0,0xe7
 data 4,16,4,0,4,12
 data END
 data "(\\1704+\\0708)$=\\1704",NORMAL,4
 data 0x00,0x00,0xc0,0xe5
 data 4,16,8,0,4,12
 data END
 data "(\\1704)$=\\1704",NORMAL,4
 data 0x00,0x00,0xc0,0xe5
 data 4,16,4,12
 data END
 data "\\1704=\\1704",NORMAL,4
 data 0x00,0x00,0xa0,0xe1
 data 4,12,4,0
 data END
 data "\\1704=&\\0632",NORMAL,12
 data 0x00,0x00,0x9f,0xe5
 data 0x00,0x00,0x00,0xea
 data 0x00,0x00,0x00,0x00
 data 4,12,32,64
 data END
 data "\\1704=\\0708",NORMAL,4
 data 0x00,0x00,0xa0,0xe3
 data 4,12,8,0
 data END
 data "jmp \\0426",NORMAL,4
 data 0x00,0x00,0x00,0xea
 data 2,120,24,0
 data END
 data "jeq \\0426",NORMAL,4
 data 0x00,0x00,0x00,0x0a
 data 2,120,24,0
 data END
 data "jne \\0426",NORMAL,4
 data 0x00,0x00,0x00,0x1a
 data 2,120,24,0
 data END
 data "jpl \\0426",NORMAL,4
 data 0x00,0x00,0x00,0x5a
 data 2,120,24,0
 data END
 data "jmi \\0426",NORMAL,4
 data 0x00,0x00,0x00,0x4a
 data 2,120,24,0
 data END
 data "jge \\0426",NORMAL,4
 data 0x00,0x00,0x00,0xaa
 data 2,120,24,0
 data END
 data "jgt \\0426",NORMAL,4
 data 0x00,0x00,0x00,0xca
 data 2,120,24,0
 data END
 data "jlt \\0426",NORMAL,4
 data 0x00,0x00,0x00,0xba
 data 2,120,24,0
 data END
 data "jle \\0426",NORMAL,4
 data 0x00,0x00,0x00,0xda
 data 2,120,24,0
 data END
 data "call \\0426",NORMAL,4
 data 0x00,0x00,0x00,0xeb
 data 2,120,24,0
 data END
 data "ret",NORMAL,4
 data 0x0e,0xf0,0xa0,0xe1
 data END
 data "clz \\1704,\\1704",NORMAL,4
 data 0x10,0x0f,0x6f,0xe1
 data 4,12,4,0
 data END
 data "svc \\0724",NORMAL,4
 data 0x00,0x00,0x00,0xef
 data 24,0
 data END
 data "nop",NORMAL,4
 data 0x00,0x00,0xa0,0xe1
 data END
 data NULL

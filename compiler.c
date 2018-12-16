
/*


  "compiler.c" 

    oregengo_R
    独自言語コンパイラ ver 1.1
   
  asm_x64形式のアセンブラソースファイルを生成
  ソースファイル名は "asm.s"となる

*/

#include <stdio.h>
#include <string.h>

/* パス１定義データ （宣言文の定義）*/
char*  pass1[] = {
  " long \\#(\\),\\#(\\),\\#(\\),\\#(\\)", " align 8\n\\1: memory \\2*8\n\\3: memory \\4*8\n\\5: memory \\6*8\n\\7: memory \\8*8\n",
  " long \\#(\\),\\#(\\),\\#(\\)",         " align 8\n\\1: memory \\2*8\n\\3: memory \\4*8\n\\5: memory \\6*8\n",
  " long \\#(\\),\\#(\\)",                 " align 8\n\\1: memory \\2*8\n\\3: memory \\4*8\n",
  " long \\#(\\)",                         " align 8\n\\1: memory \\2*8\n",

  " long \\#,\\#,\\#,\\#,\\#,\\#,\\#,\\#", " align 8\n\\1: memory 8\n\\2: memory 8\n\\3: memory 8\n\\4: memory 8\n\\5: memory 8\n\\6: memory 8\n\\7: memory 8\n\\8: memory 8\n",
  " long \\#,\\#,\\#,\\#,\\#,\\#,\\#",     " align 8\n\\1: memory 8\n\\2: memory 8\n\\3: memory 8\n\\4: memory 8\n\\5: memory 8\n\\6: memory 8\n\\7: memory 8\n",
  " long \\#,\\#,\\#,\\#,\\#,\\#",         " align 8\n\\1: memory 8\n\\2: memory 8\n\\3: memory 8\n\\4: memory 8\n\\5: memory 8\n\\6: memory 8\n",
  " long \\#,\\#,\\#,\\#,\\#",             " align 8\n\\1: memory 8\n\\2: memory 8\n\\3: memory 8\n\\4: memory 8\n\\5: memory 8\n",
  " long \\#,\\#,\\#,\\#",                 " align 8\n\\1: memory 8\n\\2: memory 8\n\\3: memory 8\n\\4: memory 8\n",
  " long \\#,\\#,\\#",                     " align 8\n\\1: memory 8\n\\2: memory 8\n\\3: memory 8\n",
  " long \\#,\\#",                         " align 8\n\\1: memory 8\n\\2: memory 8\n",
  " long \\#",                             " align 8\n\\1: memory 8\n",

  " int \\!(\\),\\!(\\),\\!(\\),\\!(\\)", " align 8\n\\1: memory \\2*4\n\\3: memory \\4*4\n\\5: memory \\6*4\n\\7: memory \\8*4\n",
  " int \\!(\\),\\!(\\),\\!(\\)",         " align 8\n\\1: memory \\2*4\n\\3: memory \\4*4\n\\5: memory \\6*4\n",
  " int \\!(\\),\\!(\\)",                 " align 8\n\\1: memory \\2*4\n\\3: memory \\4*4\n",
  " int \\!(\\)",                         " align 8\n\\1: memory \\2*4\n",

  " int \\!,\\!,\\!,\\!,\\!,\\!,\\!,\\!", " align 8\n\\1: memory 4\n\\2: memory 4\n\\3: memory 4\n\\4: memory 4\n\\5: memory 4\n\\6: memory 4\n\\7: memory 4\n\\8: memory 4\n",
  " int \\!,\\!,\\!,\\!,\\!,\\!,\\!",     " align 8\n\\1: memory 4\n\\2: memory 4\n\\3: memory 4\n\\4: memory 4\n\\5: memory 4\n\\6: memory 4\n\\7: memory 4\n",
  " int \\!,\\!,\\!,\\!,\\!,\\!",         " align 8\n\\1: memory 4\n\\2: memory 4\n\\3: memory 4\n\\4: memory 4\n\\5: memory 4\n\\6: memory 4\n",
  " int \\!,\\!,\\!,\\!,\\!",             " align 8\n\\1: memory 4\n\\2: memory 4\n\\3: memory 4\n\\4: memory 4\n\\5: memory 4\n",
  " int \\!,\\!,\\!,\\!",                 " align 8\n\\1: memory 4\n\\2: memory 4\n\\3: memory 4\n\\4: memory 4\n",
  " int \\!,\\!,\\!",                     " align 8\n\\1: memory 4\n\\2: memory 4\n\\3: memory 4\n",
  " int \\!,\\!",                         " align 8\n\\1: memory 4\n\\2: memory 4\n",
  " int \\!",                             " align 8\n\\1: memory 4\n",

  " short \\%(\\),\\%(\\),\\%(\\),\\%(\\)", " align 8\n\\1: memory \\2*2\n\\3: memory \\4*2\n\\5: memory \\6*2\n\\7: memory \\8*2\n",
  " short \\%(\\),\\%(\\),\\%(\\)",         " align 8\n\\1: memory \\2*2\n\\3: memory \\4*2\n\\5: memory \\6*2\n",
  " short \\%(\\),\\%(\\)",                 " align 8\n\\1: memory \\2*2\n\\3: memory \\4*2\n",
  " short \\%(\\)",                         " align 8\n\\1: memory \\2*2\n",

  " short \\%,\\%,\\%,\\%,\\%,\\%,\\%,\\%", " align 8\n\\1: memory 2\n\\2: memory 2\n\\3: memory 2\n\\4: memory 2\n\\5: memory 2\n\\6: memory 2\n\\7: memory 2\n\\8: memory 2\n",
  " short \\%,\\%,\\%,\\%,\\%,\\%,\\%",     " align 8\n\\1: memory 2\n\\2: memory 2\n\\3: memory 2\n\\4: memory 2\n\\5: memory 2\n\\6: memory 2\n\\7: memory 2\n",
  " short \\%,\\%,\\%,\\%,\\%,\\%",         " align 8\n\\1: memory 2\n\\2: memory 2\n\\3: memory 2\n\\4: memory 2\n\\5: memory 2\n\\6: memory 2\n",
  " short \\%,\\%,\\%,\\%,\\%",             " align 8\n\\1: memory 2\n\\2: memory 2\n\\3: memory 2\n\\4: memory 2\n\\5: memory 2\n",
  " short \\%,\\%,\\%,\\%",                 " align 8\n\\1: memory 2\n\\2: memory 2\n\\3: memory 2\n\\4: memory 2\n",
  " short \\%,\\%,\\%",                     " align 8\n\\1: memory 2\n\\2: memory 2\n\\3: memory 2\n",
  " short \\%,\\%",                         " align 8\n\\1: memory 2\n\\2: memory 2\n",
  " short \\%",                             " align 8\n\\1: memory 2\n",

  " char \\$(\\),\\$(\\),\\$(\\),\\$(\\)", " align 8\n\\1: memory \\2\n\\3: memory \\4\n\\5: memory \\6\n\\7: memory \\8\n",
  " char \\$(\\),\\$(\\),\\$(\\)",         " align 8\n\\1: memory \\2\n\\3: memory \\4\n\\5: memory \\6\n",
  " char \\$(\\),\\$(\\)",                 " align 8\n\\1: memory \\2\n\\3: memory \\4\n",
  " char \\$(\\)",                         " align 8\n\\1: memory \\2\n",

  " char \\$,\\$,\\$,\\$,\\$,\\$,\\$,\\$", " align 8\n\\1: memory 1\n\\2: memory 1\n\\3: memory 1\n\\4: memory 1\n\\5: memory 1\n\\6: memory 1\n\\7: memory 1\n\\8: memory 1\n",
  " char \\$,\\$,\\$,\\$,\\$,\\$,\\$",     " align 8\n\\1: memory 1\n\\2: memory 1\n\\3: memory 1\n\\4: memory 1\n\\5: memory 1\n\\6: memory 1\n\\7: memory 1\n",
  " char \\$,\\$,\\$,\\$,\\$,\\$",         " align 8\n\\1: memory 1\n\\2: memory 1\n\\3: memory 1\n\\4: memory 1\n\\5: memory 1\n\\6: memory 1\n",
  " char \\$,\\$,\\$,\\$,\\$",             " align 8\n\\1: memory 1\n\\2: memory 1\n\\3: memory 1\n\\4: memory 1\n\\5: memory 1\n",
  " char \\$,\\$,\\$,\\$",                 " align 8\n\\1: memory 1\n\\2: memory 1\n\\3: memory 1\n\\4: memory 1\n",
  " char \\$,\\$,\\$",                     " align 8\n\\1: memory 1\n\\2: memory 1\n\\3: memory 1\n",
  " char \\$,\\$",                         " align 8\n\\1: memory 1\n\\2: memory 1\n",
  " char \\$",                             " align 8\n\\1: memory 1\n",

  " count \\#,\\#,\\#,\\#,\\#,\\#,\\#,\\#", " align 8\n\\1: memory 32\n\\2: memory 32\n\\3: memory 32\n\\4: memory 32\n\\5: memory 32\n\\6: memory 32\n\\7: memory 32\n\\8: memory 32\n",
  " count \\#,\\#,\\#,\\#,\\#,\\#,\\#",     " align 8\n\\1: memory 32\n\\2: memory 32\n\\3: memory 32\n\\4: memory 32\n\\5: memory 32\n\\6: memory 32\n\\7: memory 32\n",
  " count \\#,\\#,\\#,\\#,\\#,\\#",         " align 8\n\\1: memory 32\n\\2: memory 32\n\\3: memory 32\n\\4: memory 32\n\\5: memory 32\n\\6: memory 32\n",
  " count \\#,\\#,\\#,\\#,\\#",             " align 8\n\\1: memory 32\n\\2: memory 32\n\\3: memory 32\n\\4: memory 32\n\\5: memory 32\n",
  " count \\#,\\#,\\#,\\#",                 " align 8\n\\1: memory 32\n\\2: memory 32\n\\3: memory 32\n\\4: memory 32\n",
  " count \\#,\\#,\\#",                     " align 8\n\\1: memory 32\n\\2: memory 32\n\\3: memory 32\n",
  " count \\#,\\#",                         " align 8\n\\1: memory 32\n\\2: memory 32\n",
  " count \\#",                             " align 8\n\\1: memory 32\n",

  NULL
};


/* パス２定義データ （if-then 文の定義） */
char*  pass2[] = {
 ".data", "/ align 8/\n",
 " .data", "/ align 8/\n", 
  " if \\<>\\ then \\", " if \\1=\\2 goto L\\0\n \\3\nL\\0:\n",
  " if \\>=\\ then \\", " if \\1<\\2 goto L\\0\n \\3\nL\\0:\n",
  " if \\<=\\ then \\", " if \\1>\\2 goto L\\0\n \\3\nL\\0:\n",
  " if \\>\\ then \\",  " if \\1<=\\2 goto L\\0\n \\3\nL\\0:\n",
  " if \\<\\ then \\",  " if \\1>=\\2 goto L\\0\n \\3\nL\\0:\n",
  " if \\=\\ then \\",  " if \\1<>\\2 goto L\\0\n \\3\nL\\0:\n",

  "\\: \\",  "\\1:\n \\2\n",
  "\\",      "\\1\n",

  NULL
};


/* パス３ 定義データ （if-goto,for-next文の定義） */
char*  pass3[] = {
  "/\\/",  "/\\1/\n",
  "\\:",    "\\1:\n",

  " long \\",      "",
  " int \\",      "",
  " short \\",    "",
  " char \\",     "",
  " count \\",    "",
  " const \\ \\", "/\\1: equ \\2/\n",

  " if \\<>\\ goto \\",            " \\1,\n \\2,\n jnz \\3\n",
  " if \\>=\\ goto \\",            " \\1,\n \\2,\n jge \\3\n",
  " if \\<=\\ goto \\",            " \\2,\n \\1,\n jge \\3\n",
  " if \\>\\ goto \\",             " \\2,\n \\1,\n jlt \\3\n",
  " if \\<\\ goto \\",             " \\1,\n \\2,\n jlt \\3\n",
  " if \\=\\ goto \\",             " \\1,\n \\2,\n jz \\3\n",
  " goto \\",                      " jmp \\1\n",

// for-next (cpu依存する部分あり) ---> ジャンプアドレス($+xxx)
  " for \\#=\\ to \\ step \\",     " \\2,\n \\1#=\n \\3,\n \\1+8#=\n \\4,\n \\1+16#=\n 11(rip),\n \\1+24#=\n",
  " for \\#=\\ to \\",             " \\2,\n \\1#=\n \\3,\n \\1+8#=\n 1,\n \\1+16#=\n 11(rip),\n \\1+24#=\n",
  " next \\#",                     " \\1#,\n \\1+8#,\n jz $+73\n \\1#,\n \\1+16#,\n +\n \\1#=\n \\1+24#,\n jmp@\n",

  " data \\,\\,\\,\\,\\,\\,\\,\\", " data\\1\n data\\2\n data\\3\n data\\4\n data\\5\n data\\6\n data\\7\n data\\8\n",
  " data \\,\\,\\,\\,\\,\\,\\",    " data\\1\n data\\2\n data\\3\n data\\4\n data\\5\n data\\6\n data\\7\n",
  " data \\,\\,\\,\\,\\,\\",       " data\\1\n data\\2\n data\\3\n data\\4\n data\\5\n data\\6\n",
  " data \\,\\,\\,\\,\\",          " data\\1\n data\\2\n data\\3\n data\\4\n data\\5\n",
  " data \\,\\,\\,\\",             " data\\1\n data\\2\n data\\3\n data\\4\n",
  " data \\,\\,\\",                " data\\1\n data\\2\n data\\3\n",
  " data \\,\\",                   " data\\1\n data\\2\n",
  " data \\",                      " data\\1\n",

  " \\ \\ \\ \\ \\ \\ \\ \\",      " \\1\n \\2\n \\3\n \\4\n \\5\n \\6\n \\7\n \\8\n",
  " \\ \\ \\ \\ \\ \\ \\",         " \\1\n \\2\n \\3\n \\4\n \\5\n \\6\n \\7\n",
  " \\ \\ \\ \\ \\ \\",            " \\1\n \\2\n \\3\n \\4\n \\5\n \\6\n",
  " \\ \\ \\ \\ \\",               " \\1\n \\2\n \\3\n \\4\n \\5\n",
  " \\ \\ \\ \\",                  " \\1\n \\2\n \\3\n \\4\n",
  " \\ \\ \\",                     " \\1\n \\2\n \\3\n",
  " \\ \\",                        " \\1\n \\2\n",
  " \\",                           " \\1\n",

  NULL
};


/*  パス4 コードジェネレータ定義データ */
#include "codegen.c"

/* プロトタイプ宣言  */
void catFile( char* fname );
void strProcess();
void compile( int pass );

//変数宣言
#define MAX_PASS 4    // コンパイラのパス回数 */
#define LEN_ARG  128  // 引数の最大の長さ

/* コンパイラ定義データ */
char** RefData[MAX_PASS] = { pass1, pass2, pass3, codegen };
char* InFile  =   "__tmp1";
char* OutFile = "__tmp2";
char* StrFile =  "__str";
char* VarFile =  "__var";
char* AsmFile = "asm.s";
char* Tmp;
char   *Comment1 = "/*", *Comment2 = "//";
int     StringID;
FILE  *hInFile, *hOutFile, *hStrFile;


//必要なデータの初期化部分
int main( int argc, char* argv[] ){
  int offset;
  unsigned int i;
  char buf[32];

  if( argc < 2 ) return 0;

//  printf("compile:\n");

  /* 文字列IDを初期化する */
  StringID = 1;

  /* 入力ファイルの結合 */
  if( ( hOutFile = fopen( OutFile, "w") ) == NULL ){
    printf("ファイルが開けません");
    return 0;
  }
  for( i = 1; i < argc; i++ ){
    catFile( argv[ i ] );
  }  
  fclose( hOutFile );
  Tmp     = OutFile;
  OutFile = InFile;
  InFile  = Tmp;

  /* コンパイル開始 */
  strProcess();  // 文字列の処理
  Tmp     = InFile;
  InFile  = OutFile;
  OutFile = VarFile;
  VarFile = Tmp;
  compile( 0 );   /* 宣言文の処理 */
  Tmp     = OutFile;
  OutFile = VarFile;
  VarFile = Tmp;

  for( i = 1; i < MAX_PASS; i++ ){
    compile( i );  // 手続き文の処理
    Tmp     = OutFile;
    OutFile = InFile;
    InFile  = Tmp;
  }

  /* 出力ファイル（アセンブラソース）の生成 */
  if( ( hOutFile = fopen( AsmFile, "w") ) != NULL ){
    catFile( InFile );  // プログラム
    fprintf( hOutFile, "  align 8\n" );
    catFile( StrFile );  // 文字列
    fprintf( hOutFile, "  align 8\n" );
    catFile( VarFile );  // 変数
    fclose( hOutFile );
  }
}


/* ファイル結合サブルーチン */
void catFile( char* fname ){
  int c;

  if( ( hInFile = fopen( fname,  "r" ) ) != NULL ){
    while( ( c = getc( hInFile ) ) != EOF )  putc( c, hOutFile );
    fclose( hInFile );
  }
  else{
    printf( "ファイル結合: ファイル\"%s\"を開くことができません\n", fname ) ;
  }

}


/* 文字列処理サブルーチン(ダブルクォーテーションで囲まれた文字列をバイトコードに変換する) */
void strProcess(){
  int  c;

  if( ( hInFile = fopen( InFile,  "r" ) ) == NULL ){
    printf( "文字列処理:入力エラー" ) ;
    return;
  }
  if( ( hOutFile = fopen( OutFile, "w") ) == NULL ){
    printf( "文字列処理:出力エラー" ) ;
    close( hInFile );
    return;
  }
  if( ( hStrFile = fopen( StrFile, "w") ) == NULL ){
    printf( "文字列処理:文字列ファイル出力エラー" ) ;
    fclose( hInFile );
    fclose( hOutFile );
    return;
  }
  while( ( c = getc( hInFile ) ) != EOF ){
    if( c == (int)'\"' ){
      fprintf( hOutFile, "S%d", StringID );
      fprintf( hStrFile, "S%d:\n", StringID++ );
      while( ( c = getc( hInFile  ) ) != '\"' && c != EOF ){
        fprintf( hStrFile, "  byte %d\n", c );
      }
      fprintf( hStrFile, "  byte 0\n" );
    }
    else  putc( c, hOutFile );
  }
  fclose( hInFile );
  fclose( hOutFile );
  fclose( hStrFile );
}


/* コンパイル処理サブルーチン */
void compile( int pass ){

  char buf[1024], outbuf[1024], arg[10][LEN_ARG];
  char *source, **pattern, *ref, *out, *p, *q, *s;
  int  line, arg_p, i;

  if( ( hInFile  = fopen( InFile,  "r" ) ) == NULL ){
    printf("中間ファイルの読み込みでエラーが発生しました,pass=%d\n", pass);
    return;
  }
  if( ( hOutFile =  fopen( OutFile, "w" ) ) == NULL ){
    close( hInFile );
    printf("中間ファイルの書き込みでエラーが発生しました, pass=%d\n", pass);
    return;
  }

  line = 1;
  while( fgets(buf, 1024, hInFile ) != NULL ){

//printf("%d: %s\n", line, buf );

    /* コメントをすてる */
    if( ( s = strstr( buf, Comment1 ) ) != NULL ) *s = '\0';
    if( ( s = strstr( buf, Comment2 ) ) != NULL ) *s = '\0';

    /* 不要なスペースをすてる */
    for( i = strlen( buf ) - 1; i >= 0 && (buf[ i ] == ' ' || buf[ i ] == '\n'); i-- ) ;
    buf[ i + 1 ] = '\0';

    /* 文字列ポインタ arg[0] に現在の行を代入する */
    sprintf( arg[0], "%d", line );

    /* 参照パターンを設定する */
    pattern = RefData[ pass ];

    /* パターンの比較 */
    next_pattern:  
    while( *pattern != NULL ){
      source = buf;
      ref = *pattern++;
      out = *pattern++;
      arg_p  = 1;

      /* １文字ごとに比較する */
      while( *ref != '\0' ){
        char* xarg;
        switch( *ref ){

        /* スペースの場合 */
        case ' ':
          if( *source != ' ' ) goto next_pattern;
          while( *source == ' ' ) source++;
          if( *source == '\0' ) goto next_pattern;
          ref++;
          break;

        /* '\' 引数がある場合  */
        case '\\':
          xarg = arg[ arg_p ];
          ref++;

          /* 引数を分離する */
          while( *source != *ref ){
            *xarg++ = *source++;
            if( *source == '\0' && *ref != '\0' ) goto next_pattern; // 引数が途中で終了したらミスマッチと判定
          }
          *xarg = '\0';
          if( *arg[ arg_p ] == '\0' ) goto next_pattern; // 引数が空の場合はミスマッチと判定
          arg_p++;
          break;

        /* 上記以外の文字のとき */
        default:
          if( *source++ != *ref++ ) goto next_pattern; // 文字が違っていたらミスマッチと判定
        }
      }
      if( *source != '\0' ) goto next_pattern; // 余分な文字列が残っていたらミスマッチと判定

      /* パターンの比較が成功したら引数を展開して出力 */
      p = outbuf;
      while( *out != '\0' ){
        if( *out == '\\' ){
          q = arg[ (int)out[1] - '0' ];
          out += 2;
          while( *q != '\0' ) *p++ = *q++;
        }
        else *p++ = *out++;
      }
      *p = '\0';
      fprintf( hOutFile, "%s", outbuf );
      break;
    }

//    /* マッチするパターンが無ければメッセージを表示する */
//    if( *pattern == NULL ){
//      printf( "マッチするパターンがありませんでした\n" );
//    }

    line++;
  }

  /* コンパイル終了 */
  fclose( hInFile );
  fclose( hOutFile );
}

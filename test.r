// "test.r" ディレクトリ表示プログラム(UEFI対応)
// "compile_uefi"を実行するとコンパイルが始まります

main:
  long t#
  char buf$(1000)
  char fp$(FILE_SIZE)

  fp, dopen  // ディレクトリを開く
  loop1:
   buf, dread  t#=   // ディレクトリ情報を一つ分読み込む
    if t#=0 goto exit1
      0, buf+20$=
      buf+FILE_NAME, _nallow prints nl  // 名前の部分を表示する
    goto loop1
  exit1:
  dclose  // ディレクトリを閉じる
   "*** end ***", prints nl
  end

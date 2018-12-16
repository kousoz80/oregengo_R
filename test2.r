// ファイル"test.txt"を表示するプログラム(UEFI対応版)
main:
  char fp$(FILE_SIZE)
  long t#

  "test.txt", fp, ropen  // ファイルを開く
loop:
  fp, getc t#=
  if t#=EOF goto exit  // EOFなら終了
  if t#=10 then 13, putchar  // LFを読み込んだときはCRも出力する
  t#, putchar // 読み込んだ文字を表示
  goto loop
exit:
  fp, rclose  // ファイルを閉じる
  "*** end ***", prints nl
  end

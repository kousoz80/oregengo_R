// "test.r" ディレクトリ表示プログラム(UEFI対応)
// 1から１０までを表示するプログラム

main:
  count i#
  for i#=1 to 10
  i#, printd nl
  next i#
  end

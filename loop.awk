BEGIN {
  FS = ","
  OFS = ","
}

{
  i = 0
  cycle = 104
  code_offset = 97
  # 商品明細分だけ表示
  # 新商品コード(97行目)

  # 送料
  # 商品詳細
  while ( $(i+code_offset) != "" ) {
    for (j = 0;  j < cycle; j++) {
      format = "%s,"
      if (j + 1 == cycle) {
        format = "%s"
      }
      printf format, $(j+1+i)
    }

    # 送料など
    i += cycle
    print ""
  }
}

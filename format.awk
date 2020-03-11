BEGIN {
  FS = ","
}

# headerに関して
NR == 1 {
  printf $0
  printf ",%s,%s,%s,%s,%s\n", "送料", "代引き手数料", "決済手数料", "クーポン利用", "調整額"
}

# header以外のrecordに対して...
NR > 1 {
  items_offset = 0 # 商品明細が終わるまでのoffset
  cycle = 104 # csv headerの数
  code_offset = 97 # 商品コードまでのoffset
  uniq_price_offset = 12 # 単価までのoffset

  while ( $(items_offset + code_offset) != "" ) {
    items_offset += cycle
  }

  postage = $(items_offset + 0 * cycle + uniq_price_offset)
  cash_on_delivery_charge = $(items_offset + 1 * cycle + uniq_price_offset)
  payment_total = $(items_offset + 2  * cycle + uniq_price_offset)
  coupon_discount = $(items_offset + 3 * cycle + uniq_price_offset)
  adjustment_total= $(items_offset + 4 * cycle + uniq_price_offset)

  for (i = 0; i < items_offset / cycle; i++) {
    for (j = 0; j < cycle; j++) {
      printf "%s,", $((j + 1) + (i * cycle))
      if (j+1 == cycle) {
        printf "%s,", postage
        printf "%s,", cash_on_delivery_charge
        printf "%s,", payment_total
        printf "%s,", coupon_discount
        printf "%s", adjustment_total
        print ""
      }
    }
  }
}

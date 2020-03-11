# todo

- (大)複数配送に対応
- (小)head行の動的な取得(104固定にしてる)
- (小)枝番号と商品コードのindexの動的な取得(6,97に固定している)
- (小)shift-jisに戻す

# main

orders.csvをshift jis形式でサブスクから出力されたデフォルト形式のcsvとする

```
nkf -w orders.csv |\
awk -f add_new_line.awk |\
awk -f split_by_blank_line.awk |\
sed -e '1d' |\
awk -f format.awk > result.csv
```

# detail

1. utf8に変える
2. 枝番号1の直上に空白行を追加する(add_new_line.awk)
3. 空白行を目印に、recordを作る(split_by_blank_line.awk)
4. 注文を表現するrecordに対して、商品明細のみloopしてprintしてから送料などを表示する

## これはなに？

東工大の titech-pubnet の認証を自動で行なうための gem です。

titech-pubnet の認証の仕様に依存しているため、仕様が変われば動かなくなるかもしれません。その時は update するかもしれません。

- Mac OS X Mountain Lion, Ruby1.9.3 で動作確認済み

## 使い方

参考：Ruby1.9 のインストール（Mac OS Xの場合）。

	$ sudo port install ruby19 # MacPortsを使うなら
	$ brew install ruby # Homebrewを使うなら

gem のインストール

	gem install titech-pubnet-auth

ユーザー名、パスワードを設定

	$ titech-pubnet-auth -c

起動

	$ titech-pubnet-auth

デーモンとして起動

	$ titech-pubnet-auth -d

## ログイン時に毎回起動（Mac OS X Mountain Lion の場合）

色々あるけど以下が簡単。

1. 「システム環境設定」->「ユーザとグループ」->「ログイン項目」の＋ボタンで起動スクリプトを追加。
2. （デフォルトだとプロセス終了時にターミナル.appが閉じない。これが煩わしい場合は、）ターミナルを起動して、「環境設定」->「設定タブ」->「シェル」で、「シェルの終了時」の動作を「ウィンドウを閉じる」にする。

## TODO

- パスワードを暗号化して保管
  - 正しいやり方調べる

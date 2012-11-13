# Titech-Pubnet-Auth
## これはなに？

東工大の titech-pubnet の認証を自動で行なうための gem です。

Mac OS X Mountain Lion, Ruby1.9.3 で動作確認済みです。たぶん Ruby1.9 じゃないと動きません。

titech-pubnet の認証の仕様に依存しているため、仕様が変われば動かなくなるかもしれません。主に以下のようなものの内容に依存していると思います。

- 認証ページのドメイン
- 認証ページのフォーム
- 認証ページのloginscript.js
- titech-pubnet の HTTPプロキシ

## 使い方

参考：Ruby1.9 のインストール（Mac OS Xの場合）。

	$ sudo port install ruby19 # MacPortsを使うなら
	$ brew install ruby # Homebrewを使うなら

gem のインストール [^1]

	$ gem install titech-pubnet-auth

最初に、ユーザー名、パスワードを設定

	$ titech-pubnet-auth -c

起動

	$ titech-pubnet-auth

デーモンとして起動

	$ titech-pubnet-auth -d
	$ titech-pubnet-auth-daemon # これでもOK

その他、オプションは`$ titech-pubnet-auth -h`で。

### ログイン時に起動する方法（Mac OS X の場合）

色々あるけど以下だとほぼGUIで完結する。

1. 「システム環境設定」→「ユーザとグループ」→「ログイン項目」に起動スクリプト`titech-pubnet-auth-daemon`を追加（`$ which titech-pubnet-auth-daemon`とかで場所を調べて、Finder上で⌘gでパス指定して移動できる）。
2. （デフォルトだとプロセス終了時にターミナル.appが閉じない。これが煩わしい場合、）ターミナルを起動して、「環境設定」→「設定タブ」→「シェル」で、「シェルの終了時」の動作を「ウィンドウを閉じる」にする。

[^1]: 依存している gem の一つである nokogiri（XMLパーサー）が native extension を使っていて必要なものが無いと install で失敗するかも。http://nokogiri.org/tutorials/installing_nokogiri.html を参照。

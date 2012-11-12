## これはなに？

東工大の titech-pubnet の認証を自動で行なうための gem です。

Mac OS X Mountain Lion, Ruby1.9.3 で動作確認済みです。たぶん Ruby1.9 じゃないと動きません。

titech-pubnet の認証の仕様に依存しているため、仕様が変われば動かなくなるかもしれません。その時は update するかもしれません。主に以下のようなものの内容に依存していると思います。

- 認証ページのドメイン
- 認証ページのフォーム
- 認証ページのloginscript.js
- titech-pubnet の HTTPプロキシ（config/proxy.ymlで再設定可）

## 使い方

参考：Ruby1.9 のインストール（Mac OS Xの場合）。

	$ sudo port install ruby19 # MacPortsを使うなら
	$ brew install ruby # Homebrewを使うなら

gem のインストール

	gem install titech-pubnet-auth

最初に、ユーザー名、パスワードを設定

	$ titech-pubnet-auth -c

起動

	$ titech-pubnet-auth


デーモンとして起動

	$ titech-pubnet-auth -d
	$ titech-pubnet-auth-daemon # これでもOK

その他、オプションは`$ titech-pubnet-auth -h`で。

### ログイン時に起動する方法（Mac OS X の場合）

色々あるけど以下が簡単。

1. 「システム環境設定」→「ユーザとグループ」→「ログイン項目」に起動スクリプト`titech-pubnet-auth-daemon`を追加。
2. （デフォルトだとプロセス終了時にターミナル.appが閉じない。これが煩わしい場合は、）ターミナルを起動して、「環境設定」→「設定タブ」→「シェル」で、「シェルの終了時」の動作を「ウィンドウを閉じる」にする。

## TODO

- 接続確認のサンプルサイト増やす
- パスワードを暗号化して保管
  - 正しいやり方調べる
- Logger
- テスト

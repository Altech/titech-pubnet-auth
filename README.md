# Titech-Pubnet-Auth
## これはなに？

titech-pubnet の認証を自動で行なうための gem です。

titech-pubnet の認証の仕様に依存しているため、仕様が変われば動かなくなるかもしれません。主に以下のようなものの内容に依存していると思います。

- 認証ページのドメイン
- 認証ページのフォーム
- 認証ページのloginscript.js
- titech-pubnet の HTTPプロキシ

![](https://raw.github.com/Altech/titech-pubnet-auth/master/capture.png)

titech-pubnet に接続すると自動で認証が行われる（デスクトップアラートは Mac のみ）。

## 使い方

参考：Ruby のインストール（Mac OS Xの場合）。

	$ brew install ruby # Homebrewを使う場合

gem のインストール

	$ gem install titech-pubnet-auth # titech-pubnet 経由でインストールするなら引数として " -r -p http://131.112.125.238:3128" を追加

最初に、ユーザー名、パスワードを設定

	$ titech-pubnet-auth -c

起動

	$ titech-pubnet-auth

デーモンとして起動

	$ titech-pubnet-auth -d
	$ titech-pubnet-auth-daemon # これでもOK

その他、オプションは`$ titech-pubnet-auth -h`で。

### ログイン時に起動する方法（Mac OS X の場合）

色々あるけど以下だとほぼGUIで完結する。CUIなら launchd など。

1. 「システム環境設定」→「ユーザとグループ」→「ログイン項目」に起動スクリプト`titech-pubnet-auth-daemon`を追加（`$ which titech-pubnet-auth-daemon`とかで場所を調べて、Finder上で⌘gでパス指定して移動できる）。
2. （デフォルトだとプロセス終了時にターミナル.appが閉じない。これが煩わしい場合、）ターミナルを起動して、「環境設定」→「設定タブ」→「シェル」で、「シェルの終了時」の動作を「ウィンドウを閉じる」にする。

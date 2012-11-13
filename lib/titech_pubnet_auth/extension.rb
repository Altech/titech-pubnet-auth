# -*- coding: utf-8 -*-

require 'colorize'

module Kernel
  #
  # バッチ処理の経過報告用メソッド。ファイル名と時刻を付けて出力してくれる。
  #
  def mputs(tag,msg)
    s = Time.now.strftime("%Y-%m-%d %H:%M:%S").green + "\t" + caller.first[/([^:]*):/,1].split('/').last.blue + "\t" + tag + "：" + msg.to_s
    puts(s)
    return msg
  end
end

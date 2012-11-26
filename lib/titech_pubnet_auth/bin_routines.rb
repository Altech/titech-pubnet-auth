# -*- coding: utf-8 -*-

class TitechPubnetAuth
  module BinRoutines
    module_function
    
    if RbConfig::CONFIG["target_os"].downcase =~ /^darwin/
      require 'terminal-notifier'
      
      def notifier
        TerminalNotifier.notify(nil,:title => 'Titech Punet Auth', :subtitle => 'Connected!') 
      end

      def error_notifier(e)
        TerminalNotifier.notify(e.inspect,:title => 'Titech Punet Auth',:subtitle => 'Caught an unexpected error!')
      end

    else
      def notifier; end
      def error_notifier; end
    end

    require 'colorize'

    def mputs(tag,msg)
      s = Time.now.strftime("%Y-%m-%d %H:%M:%S").green + "\t" + caller.first[/([^:]*):/,1].split('/').last.blue + "\t" + tag + "：" + msg.to_s
      puts(s)
      return msg
    end

  end
end

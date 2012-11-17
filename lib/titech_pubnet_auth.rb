# -*- coding: utf-8 -*-

require 'mechanize'
require 'uri'
require 'yaml'

$:.unshift File.dirname(__FILE__)
require 'titech_pubnet_auth/extension'


class TitechPubnetAuth
  BASE_DIR = File.expand_path('..',File.dirname(__FILE__))

  SAMPLE_URI = ->{%w[www.titech.ac.jp github.com twitter.com].map{|uri| URI.parse("http://#{uri}")}[rand(3)]}
  
  HTTP_PROXY = {ip: '131.112.125.238', port: 3128}

  def initialize(opt = {open_timeout: 3})
    @agent, @agent_with_proxy = Mechanize.new, Mechanize.new
    [@agent,@agent_with_proxy].each{|agent|
      agent.follow_meta_refresh = true
      agent.open_timeout = opt[:open_timeout]
    }
    @agent_with_proxy.set_proxy(HTTP_PROXY[:ip], HTTP_PROXY[:port])

    @private = YAML.load(File::open(File::expand_path('config/private.yml',BASE_DIR),'r'))
  end

  #
  # called if network_available? and not is_connected?
  #
  def auth(sample_uri = SAMPLE_URI.call)
    auth_page = @agent.get(sample_uri)
    return false if auth_page.uri.hostname != 'wlanauth.noc.titech.ac.jp'

    auth_page.form do |form|
      form.buttonClicked = 4
      form.redirect_url = sample_uri
      form.username = @private['username']
      form.password = @private['password']
    end.submit
    
    return is_connected?
  end

  #
  # called if network_available?
  #
  def is_connected?(sample_uri = SAMPLE_URI.call)
    return @agent_with_proxy.get(sample_uri).uri.hostname == sample_uri.hostname
  rescue # retry without the proxy
    return @agent.get(sample_uri).uri.hostname == sample_uri.hostname
  end

  #
  # note: titech-pubnet allows to access portal.titech.ac.jp without authentication.
  #
  def network_available?
    @agent.get('http://portal.titech.ac.jp')
    return true
  rescue => e
    return false
  end

end

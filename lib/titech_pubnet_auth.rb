# -*- coding: utf-8 -*-

require 'mechanize'
require 'uri'
require 'yaml'

$:.unshift(File.dirname(__FILE__))
require 'titech_pubnet_auth/bin_routines'
require 'titech_pubnet_auth/extensions'
require 'titech_pubnet_auth/config'

class TitechPubnetAuth
  SAMPLE_URI = URI "http://example.org"
  HTTP_PROXY = {ip: '131.112.125.238', port: 3128}

  def initialize(opt = {})
    opt = {open_timeout: 5}.merge(opt)
    @agent, @agent_with_proxy = Mechanize.new, Mechanize.new
    [@agent, @agent_with_proxy].each{|agent|
      agent.follow_meta_refresh = true
      agent.open_timeout = opt[:open_timeout]
    }
    @agent_with_proxy.set_proxy(HTTP_PROXY[:ip], HTTP_PROXY[:port])

    @config = opt[:config] || TitechPubnetAuth::Config.get
    fail "config not found" unless @config
  end

  #
  # called if network_available? and not is_connected?
  #
  def auth(sample_uri = SAMPLE_URI)
    auth_page = @agent.get(sample_uri)
    return false if auth_page.uri.hostname != 'wlanauth.noc.titech.ac.jp'

    auth_page.form do |form|
      form.buttonClicked = 4
      form.redirect_url = sample_uri
      form.username = @config.username
      form.password = @config.password
    end.submit

    return is_connected?
  end

  #
  # called if network_available?
  #
  def is_connected?(sample_uri = SAMPLE_URI)
    compare_uri_by_first_part sample_uri, @agent_with_proxy.get(sample_uri).uri
  rescue # retry without the proxy
    compare_uri_by_first_part sample_uri, @agent.get(sample_uri).uri
  end

  #
  # note: titech-pubnet allows to access portal.titech.ac.jp without authentication.
  #
  def network_available?(sample_uri = SAMPLE_URI)
    @agent.get('http://portal.titech.ac.jp').to_b
  rescue # check another website just to make sure
    @agent.get(sample_uri).to_b rescue return false
  end

  private

  def compare_uri_by_first_part uri1, uri2
    uri1.hostname.split(".").first == uri2.hostname.split(".").first
  end

end

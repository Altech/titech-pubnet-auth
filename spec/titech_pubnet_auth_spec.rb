require 'spec_helper'

describe TitechPubnetAuth do

  before do
    @auth = TitechPubnetAuth.new(private: {username: 'foo', password: 'bar'})

    example_auth_page = <<-EOF
      <!doctype html>
      <head>
        <meta charset="utf-8">
      </head>
      <body>
        <form method='post' action='http://wlanauth.noc.titech.ac.jp/login'>
          <input type='text' name='username'>
          <input type='text' name='password'>
          <input type='hidden' name='buttonClicked' value='4'>
          <input type='hidden' name='redirect_url'>
          <input type='submit'>
        </form>
      </body>
    EOF

    stub_request(:get, 'http://portal.titech.ac.jp')
    stub_request(:get, 'http://example.org')
      .to_return {
        if @connected
          {body: ""}
        else
          {status: 301, headers: {'Location' => 'http://wlanauth.noc.titech.ac.jp/'}}
        end
      }
    stub_request(:get, 'http://wlanauth.noc.titech.ac.jp/')
      .to_return(body: example_auth_page, headers: {'Content-Type' => 'text/html'})
    stub_request(:post, 'http://wlanauth.noc.titech.ac.jp/login')
      .to_return {
        @connected = true
        {body: ""}
      }
  end

  describe '#auth' do
    it 'establishes connection' do
      @auth.auth
      expect(@auth.is_connected?).to eq true
    end
  end

  describe '#is_connected?' do

    context 'when connected' do
      it 'returns true' do
        @connected = true
        expect(@auth.is_connected?).to eq true
      end
    end

    context 'when not connected' do
      it 'returns false' do
        @connected = false
        expect(@auth.is_connected?).to eq false
      end
    end
  end

  describe '#network_available?' do

    context 'when network is enabled' do
      it 'returns true' do
        expect(@auth.network_available?).to eq true
      end
    end

    context 'when network is disabled' do
      it 'returns false' do
        stub_request(:any, //).to_raise('error')
        expect(@auth.network_available?).to eq false
      end
    end
  end
end
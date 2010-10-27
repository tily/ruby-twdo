# -*- coding: utf-8 -*-
require 'rubygems'
require 'twitter'
require 'oauth'

class TwDo
  class API
    CONF = ENV['HOME'] + '/.twdo'
    CONSUMER_TOKEN  = 'Tok5taGUA8x3VE60w79Q'
    CONSUMER_SECRET = 'qf2UedjS1A9wEqMure0wrq03wWpl4qvAyiCp0dLMd8Q'

    def initialize(*args)
      oauth = ::Twitter::OAuth.new(CONSUMER_TOKEN, CONSUMER_SECRET)
      oauth.authorize_from_access(access[:token], access[:secret])
      @twitter = ::Twitter::Base.new(oauth)
    end

    def get
      @twitter.user('tily').description
    end

    def set(val)
      @twitter.update_profile(:description => val)
    end

    private

    def access
      if File.exist?(CONF)
        YAML::load(File.read(CONF))
      else
        authorize_by_oauth
      end
    end

    def authorize_by_oauth
      consumer = OAuth::Consumer.new(
        CONSUMER_TOKEN,
        CONSUMER_SECRET,
        :site => 'http://api.twitter.com',
        :proxy => ENV['http_proxy']
      )
      request_token = consumer.get_request_token
      puts "Go to URL below and enter pin."
      puts request_token.authorize_url
      pin = ''
      until pin =~ /^\d+$/
        print '> '
        pin = STDIN.gets.chomp
      end
      begin
        access_token = request_token.get_access_token(:oauth_verifier => pin)
      rescue OAuth::Unauthorized => e
        raise TwDo::Error, 'Invalid pin.'
      end
      access = {:token => access_token.token, :secret => access_token.secret}
      File.open(CONF, 'w') {|f| f.write(access.to_yaml) }
      access
    end
  end
end

# -*- coding: utf-8 -*-
require 'rubygems'
require 'oauth'
require 'twitter'
require 'oauth/cli/twitter'

class TwDo
  class API
    include OAuth::CLI::Twitter

    CONF = ENV['HOME'] + '/.twdo'
    CONSUMER_TOKEN  = 'Tok5taGUA8x3VE60w79Q'
    CONSUMER_SECRET = 'qf2UedjS1A9wEqMure0wrq03wWpl4qvAyiCp0dLMd8Q'

    def initialize(*args)
      @access_token = get_access_token(:file => CONF)
      oauth = ::Twitter::OAuth.new(CONSUMER_TOKEN, CONSUMER_SECRET)
      oauth.authorize_from_access(@access_token.token, @access_token.secret)
      @twitter = ::Twitter::Base.new(oauth)
    end

    def get
      @twitter.user(@access_token.params[:screen_name]).description
    end

    def set(val)
      @twitter.update_profile(:description => val)
    end
  end
end

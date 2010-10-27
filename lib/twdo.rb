# -*- coding: utf-8 -*-
require 'twdo/api'

class TwDo
  class Error < StandardError; end

  MAX_CHAR        = 119
  MUST            = '□'
  DONE            = '☑'
  SEPARATOR       = '／'

  attr_accessor :api

  def list
    return @list if @list
    lines = api.get.split(SEPARATOR)
    @list = lines.map do |l|
      if l =~ /^(#{MUST}|#{DONE})(.*)$/u
        task = [$2]
        task << :done if $1 == DONE
        task
      else
        raise Error, 'invalid format. please init your TwDo list.'
      end
    end
  end

  def self.operation(name, &block)
    define_method name do |arg|
      task = nil
      if arg.is_a? String
        if !list.assoc(arg)
          raise Error, "task '#{arg}' does not exist."
        end
        task = list.assoc(arg)
      elsif arg.is_a? Integer
        if !list[arg]
          raise Error, "task #{arg} does not exist."
        end
        task = list[arg]
      end
      block.call(task, list)
    end
  end

  operation(:done) {|t, l| t[1] = :done }
  operation(:undo) {|t, l| t[1] = nil   }
  operation(:del ) {|t, l| l.delete(t)  }

  def add(name)
      if list.assoc(name)
          raise Error, 'task already exists.'
      end
      list << [name]
  end

  def init(names)
      @list = names.map {|n| [n] }
  end

  def update!
      desc = list.map {|item|
          prefix = item[1] == :done ? DONE : MUST
          prefix + item[0]
      }.join(SEPARATOR)
      raise 'Over max chars.' if desc.split(//u).size > MAX_CHAR
      api.set(desc)
  end
end

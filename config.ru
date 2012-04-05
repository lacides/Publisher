require "rubygems"
require "bundler"
Bundler.require(:default)

Dir['lib/*.rb'].each {|f| require File.expand_path(File.join(File.dirname(__FILE__), f)) }

require './application'
run Application.new
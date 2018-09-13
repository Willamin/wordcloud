#!/usr/bin/env ruby

require 'sinatra'
require 'better_errors'
require './wordcloud'

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

WORDS = WordCloud.top(20, File.read('./a-little-cloud.txt'))

get '/' do
  erb :index, locals: {words: WORDS}
end




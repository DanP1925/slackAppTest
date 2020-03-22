# frozen_string_literal: true

# myapp.rb
require 'sinatra'
require 'slack-ruby-client'
require 'dotenv/load'
Dotenv.load

get '/' do
  'Hello World!'
end

# frozen_string_literal: true

# myapp.rb
require 'sinatra'
require 'slack-ruby-client'
require 'dotenv/load'
Dotenv.load

Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
  raise 'Missing ENV[SLACK_API_TOKEN]!' unless config.token
end

client = Slack::Web::Client.new

get '/' do
  client.auth_test
end

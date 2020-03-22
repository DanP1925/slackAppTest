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
  'Hello World!'
  all_members = client.users_list
  all_members['members'].each do |member|
    if member.is_bot != true
      client.chat_postMessage(channel: member.id, text: 'Habla causita',
                              as_user: true)
      end
  end
end

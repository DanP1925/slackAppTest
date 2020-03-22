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

def make_block_question(member)
  [
    {
      "type": 'section',
      "text": {
        "type": 'mrkdwn',
        "text": "Hi #{member.real_name} :wave:"
      }
    },
    {
      "type": 'section',
      "text": {
        "type": 'mrkdwn',
        "text": 'Para marcar la hora de entrada apriete el boton. '
      },
      "accessory": {
        "type": 'button',
        "text": {
          "type": 'plain_text',
          "text": 'Marcar'
        },
        "value": member.id.to_s
      }
    }
  ]
end

get '/' do
  all_members = client.users_list
  all_members.members.each do |member|
    next unless member.is_bot != true

    block_question = make_block_question(member)
    client.chat_postMessage(channel: member.id, text: 'Buenos dias',
                            as_user: true, blocks: block_question.to_json)
  end
  status 200
  body ''
end

post '/' do
  request_data = JSON.parse(request.body.read)
  status 200
  body ''
end

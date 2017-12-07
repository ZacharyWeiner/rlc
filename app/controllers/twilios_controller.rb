class TwiliosController < ApplicationController

  def send_test
    sid = ENV['TWILIO_SID']
    token = ENV['TWILIO_AUTH_TOKEN']
    @client = Twilio::REST::Client.new sid, token
    @client.api.account.messages.create(
      from: '+19545162345',
      to: '+19546461240',
      body: 'Hey there 2'
    )
  end
end

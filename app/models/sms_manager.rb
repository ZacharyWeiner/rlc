class SmsManager
  include ActiveModel::Model
  attr_accessor :message, :to_number, :message

  def send_message
    if self.to_number.nil? || self.to_number.length < 9 || self.to_number == ""
      return
    end
      sid = ENV['TWILIO_SID']
      token = ENV['TWILIO_AUTH_TOKEN']
      @client = Twilio::REST::Client.new sid, token
      @client.api.account.messages.create(
        from: '+19708756350 ',
        to: self.to_number,
        body: self.message
      )
  end
end

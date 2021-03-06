class PagesController < ApplicationController
  layout 'locations_2'
  def index
    @header_experiences = ExperienceOccurance.where("date > ?", DateTime.now).order("date ASC").map{|eo| eo.experience}.uniq
  end

  def right_column_list
  end

  def front_desk
  end

  def send_sms
    number = params[:phone_number]
    number = number.gsub('-', "")
    sms = SmsManager.new(to_number: number, message: "Thank You For Staying at an RLC Property. To order a shuttle online please visit: http://bit.ly/2DDmP5F")
    sms.send_message
    redirect_to text_message_sent_path
  end

   def send_sms_intl
    if params[:intl_phone_number]
      number = params[:intl_phone_number]
    else
      number = params[:phone_number]
    end
    number = number.gsub('-', "")
    sms = SmsManager.new(to_number: number, message: "Thank You For Staying at an RLC Property. To order a shuttle online please visit: http://bit.ly/2DDmP5F")
    sms.send_message
    respond_to do |format|
      return format.html { redirect_to text_message_sent_path, notice: 'Text Message Sent' }
    end
   end
end

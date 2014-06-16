# SMS can only be a maximum of 160 characters.  
# If the user wants to send a message bigger than that, we need to break it up.
# We want a multi-part message to have this added to each message:
# " - Part 1 of 2"
 
# You need to fix this method, currently it will crash with > 160 char messages.
def send_sms_message(text, to, from)
  
  if text.length <= 160
    deliver_message_via_carrier(text, to, from)
  else
    number_of_parts = (text.length/146).ceil
    part_index = 1
    while text.length > 0
      if text.length <= 146
        message = text + get_appender(part_index, number_of_parts)
        deliver_message_via_carrier(message, to, from)
        text = ""
      else
        message = text[0:145] + get_appender(part_index, number_of_parts)
        deliver_message_via_carrier(message, to, from)
        text = text[146:-1]
      end
      
      part_index += 1
    end
      
        
  end
    
end


def get_appender(part_number, number_of_parts)
  " - Part #{part_number} of #{number_of_parts}"
end
 
# This method actually sends the message via a SMS carrier
# This method works, you don't change it,
def deliver_message_via_carrier(text, to, from)
  SMS_CARRIER.deliver_message(text, to, from)
end
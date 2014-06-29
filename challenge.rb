# SMS can only be a maximum of 160 characters.  
# If the user wants to send a message bigger than that, we need to break it up.
# We want a multi-part message to have this added to each message:
# " - Part 1 of 2"
 
# You need to fix this method, currently it will crash with > 160 char messages.


def slice_string(string, slice_size)
  #only works for up to 9 parts
  if string.length <= slice_size
    yield string
  else
    appender = " - Part 1 of 1"
    slicerator = string.chars.each_slice(slice_size - appender.length)
    number_of_slices = slicerator.count
    slicerator.with_index do |slice, index|
      yield "#{slice.join} - Part #{index+1} of #{number_of_slices}"
    end
  end
end


# This method actually sends the message via a SMS carrier
# This method works, you don't change it,
def deliver_message_via_carrier(text, to, from)
  puts text 
  puts to
  puts from
end

message = "test-test" * 35

slice_string(message, 160) {|slice| deliver_message_via_carrier(slice, :to, :from)}
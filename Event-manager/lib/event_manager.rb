# frozen_string_literal: true

require 'csv'

puts 'Event Manager Initialized'

# contents = File.read('event_attendees.csv') if File.exist?('event_atendees.csv')
lines = File.readlines('event_attendees.csv') if File.exist?('event_attendees.csv')
lines.each_with_index do |line, index|
  # next if line == " ,RegDate,first_Name,last_Name,Email_Address,HomePhone,Street,City,State,Zipcode\n"
  # remove row name, assuming rows wont change
  next if index.zero? # removes row name even if the rows change

  columns = line.split(',')
  name = columns[2]
  p name
end

# Using builtin csv parser
contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

contents.each do |row|
  name = row[:first_name]
  puts name
end

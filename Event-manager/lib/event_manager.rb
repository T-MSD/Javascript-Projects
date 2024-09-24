# frozen_string_literal: true

require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

def clean_number(number)
  number = number.gsub(/\D/, '')
  return number if number.length == 10

  number[1..9] if number.length == 11 && number[0] == '1'
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: %w[legislatorUpperBody legislatorLowerBody]
    ).officials
  rescue StandardError
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def save_thank_you_letter(id, form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

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

# template_letter = File.read('form_letter.html')

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

dates = Hash.new { |hash, key| hash[key] = Hash.new(0) }
week_days = Hash.new(0)

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  phone = clean_number(row[:homephone])
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)

  # personal_letter = template_letter.gsub('FIRST_NAME', name)
  # personal_letter.gsub!('LEGISLATORS', legislators)

  form_letter = erb_template.result(binding)

  save_thank_you_letter(id, form_letter)

  date = DateTime.strptime(row[:regdate], '%m/%d/%y %H:%M')
  day = date.day
  hour = date.hour
  dates[day][hour] += 1

  week_day = date.strftime('%A')
  week_days[week_day] += 1

  puts "#{name} #{zipcode} #{phone} #{date}"
end

puts dates
puts week_days

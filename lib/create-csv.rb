require 'fileutils'
require 'pdf-reader'

csv   = './src/records.csv'
paths = Dir.glob("./src/data/*")

# extract data
data  = paths.map do |path|
  a_number    = path.sub('./src/data/', '').sub(/\..*/, '').sub('_redacted', '')
  is_redacted = path.include? 'redacted'
  page_count  = PDF::Reader.new(path).page_count

  [a_number,a_number,a_number,is_redacted,page_count]
end

# write data to csv
File.open(csv, 'w') do |file| 
  file.puts("id,label,a_number,redacted,page_count")
  data.each { |d| file.puts d.join(',') }
end

# prune '_redacted' from file names
paths.each do |path|
  File.rename path, path.sub('_redacted', '')
end
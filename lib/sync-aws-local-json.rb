require 'aws-sdk-s3'
require 'dotenv'

Dotenv.load

s3        = Aws::S3::Client.new
json_docs = Dir.glob("./build/presentation/**/*.json")

json_docs.each do |file|
  key = file.sub './build/presentation/', ''
  s3.put_object({
    bucket: ENV['PRESENTATION_BUCKET_NAME'],
    key: key,
    content_type: 'application/json',
    content_disposition: 'inline',
    acl: 'public-read',
    body: File.read(file)
  })
  puts "uploaded #{key}"
end

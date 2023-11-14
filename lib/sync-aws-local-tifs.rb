require 'aws-sdk-s3'
require 'dotenv'

Dotenv.load

s3      = Aws::S3::Client.new
images  = Dir.glob("./build/image/*.tif")

images.each do |file|
  key = File.basename(file)
  s3.put_object({
    bucket: ENV['IMAGE_BUCKET_NAME'],
    key: key,
    content_type: 'image/tiff',
    content_disposition: 'inline',
    acl: 'public-read',
    body: File.read(file)
  })
  puts "uploaded #{key}"
end

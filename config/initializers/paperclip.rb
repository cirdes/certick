Paperclip::Attachment.default_options[:url] = 'certick.s3-website-us-east-1.amazonaws.com/'
Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:style/:filename'

Paperclip::Attachment.default_options[:s3_host_name] = 'certick.s3-website-us-west-2.amazonaws.com'
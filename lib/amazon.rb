class Amazon

	BUCKET = ENV["AMAZON_BUCKET"]
	CDN = ENV["AMAZON_CDN"]


	def self.upload_pdf(pdf)
		begin
			s3 = Aws::S3::Resource.new(region:'sa-east-1', 
				credentials: Aws::Credentials.new(ENV["AMAZON_KEY"], ENV["AMAZON_SECRET"]))
			bucket = s3.bucket(ENV["AMAZON_BUCKET"])
			md5 = Digest::MD5.new
			md5.update pdf
			bucket.put_object body: pdf, acl: "private", key: md5.to_s + ".pdf"
			return "#{CDN}#{md5.to_s}.pdf"
		rescue
			return nil
		end
	end

	def self.delete_object(key)
		begin
			s3 = Aws::S3::Resource.new(region:'sa-east-1', 
				credentials: Aws::Credentials.new(ENV["AMAZON_KEY"], ENV["AMAZON_SECRET"]))
			bucket = s3.bucket(ENV["AMAZON_BUCKET"])
			bucket.delete_objects({
				delete: {
					objects: [
						{
							key: key
						}
					],
					quiet: true
				}
			})
		rescue
		end
	end
end
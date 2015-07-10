class Amazon

	BUCKET = ENV["AMAZON_BUCKET"]
	CDN = ENV["AMAZON_CDN"]

	def self.get_pdf_url(pdf)
		md5 = Digest::MD5.new
		md5.update pdf
		"#{CDN}#{md5.to_s}.pdf"
	end

	def self.upload_pdf(pdf)
		begin
			s3 = Aws::S3::Resource.new(region:'sa-east-1', 
				credentials: Aws::Credentials.new(ENV["AMAZON_KEY"], ENV["AMAZON_SECRET"]))
			bucket = s3.bucket(ENV["AMAZON_BUCKET"])
			md5 = Digest::MD5.new
			md5.update pdf
			bucket.put_object body: pdf, acl: "private", key: md5.to_s + ".pdf"
			return true
		rescue
			return false
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
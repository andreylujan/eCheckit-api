class Amazon

	BUCKET = "echeckit";
	CDN = "http://d21zid65ggdxzg.cloudfront.net";


	def self.upload_pdf(pdf)
		begin
			s3 = Aws::S3::Resource.new(region:'sa-east-1', 
				credentials: Aws::Credentials.new("AKIAIYVFMP4RZQBQ2DLA", "uuaKp4MePXJ6DRJDXNdMAt92wdVDyb445RUmqxp2"))
			bucket = s3.bucket('echeckit')
			md5 = Digest::MD5.new
			md5.update pdf
			bucket.put_object body: pdf, acl: "private", key: md5.to_s + ".pdf"
			return "#{CDN}/#{md5.to_s}.pdf"
		rescue
			return nil
		end
	end
end
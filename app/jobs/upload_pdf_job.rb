class UploadPdfJob < ActiveJob::Base
  queue_as :default

  require 'amazon'

  def perform(pdf)
  	Amazon.upload_pdf(pdf)
  end
end

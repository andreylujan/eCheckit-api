class UploadPdfJob < ActiveJob::Base
  queue_as :default

  require 'amazon'

  def perform(report_id)
    
    report = Report.find(report_id)
    ac = ActionController::Base.new()
    html = html = ac.render_to_string('templates/report.html.erb', 
        locals: { :@report => report })
    pdf = WickedPdf.new.pdf_from_string(html)
    url = Amazon.upload_pdf(pdf)
    if not url.nil?
      report.update_attribute :pdf, url
    end
  end
end

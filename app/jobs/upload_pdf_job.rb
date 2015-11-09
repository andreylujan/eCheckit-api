class UploadPdfJob < ActiveJob::Base
	queue_as :default

	require 'amazon'

	def perform(report_id)
		
		report = Report.find(report_id)
		ac = ActionController::Base.new()
		# html = ac.render_to_string('templates/report.html.erb', 
		# html = ac.render_to_string('templates/report2.html.erb',
		html = ac.render_to_string('templates/' + report.workspace_id.to_s +'/report2.html.erb',
			locals: { :@report => report })
		pdf = WickedPdf.new.pdf_from_string(html, zoom: 0.8)
		url = Amazon.upload_pdf(pdf)
		if not url.nil?
			report.update_attribute :pdf, url
			report_action = report.report_actions.last
			report_action.send_create_email
		end
	end
end

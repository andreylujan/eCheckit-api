class UploadPdfJob < ActiveJob::Base
  queue_as :dom_report

  require 'amazon'

  def perform(report_id)
    report = Report.find(report_id)
    ac = ActionController::Base.new()
    # html = ac.render_to_string('templates/report.html.erb',
    # html = ac.render_to_string('templates/report2.html.erb',
    workspace_id = report.workspace_id
    workspace_id = workspace_id.to_s
    html = ac.render_to_string('templates/' + workspace_id + '/report2.html.erb',
                               locals: { :@report => report })
    pdf = WickedPdf.new.pdf_from_string(html, zoom: 0.8)
    url = Amazon.upload_pdf(pdf)
    if not url.nil?
      report.update_attribute :pdf, url
      report_action = report.report_actions.last
      if report_action
        report_action.send_create_email
      end
      if report.contact_email.present? and report.client_name == "Ewin"
      	
        UserMailer.delay(queue: "dom_email").report_email({
                                                            message: "Se ha completado la tarea de la obra #{report.client_name} - #{report.construction}",
                                                            user_name: report.contact_name,
                                                            pdf: url,
                                                            destinatary: report.contact_email,
                                                            subject: "Dom - Reporte de visita de obra",
                                                            from: "Informes Dom <informes@dom.cl>"
        })
      end
    end
  end
end

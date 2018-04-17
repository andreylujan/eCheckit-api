class UploadPdfJob < ActiveJob::Base
  queue_as :dom_report

  require 'amazon'

  def perform(report_id)
    send_emails = true
    report = Report.find(report_id)
    if report.pdf.present?
      send_emails = false
    end
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
      if send_emails
        report_action = report.report_actions.last
        if report_action
          report_action.send_create_email
        end
        creator_email = report.assigned_user.present? ? report.assigned_user.email : report.creator.email
        creator_name = report.assigned_user.present? ? report.assigned_user.name : report.creator.name
        emails = [{ name: "Informes DOM", email: "informes@dom.cl" }, { name: creator_name, email: creator_email }]
        unique_id = report.construction_info["construction_id"]
        if Construction.exists? unique_id
          construction = Construction.find(unique_id)
          construction.contacts.each do |contact|
            emails << { name: contact.name, email: contact.email }
            emails.uniq!
          end
        end
        emails.each do |email|
          if email[:email].present? and email[:email].include? '@'
            UserSendGridMailer.delay(queue: "dom_email").report_email(report_id, email[:name], email[:email])
          end
        end

        # if report.contact_email.present? and report.contact_email.include? '@' # and report.client_name == "Ewin"
        #  UserMailer.delay(queue: "dom_email").report_email(report_id, I18n.transliterate(report.contact_email))
        # end

        # UserMailer.delay(queue: "dom_email").report_email(report_id, I18n.transliterate(creator_email))
        # UserMailer.delay(queue: "dom_email").report_email(report_id, "informes@dom.cl")
      end
    end
  end
end

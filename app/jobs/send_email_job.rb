class SendEmailJob < ActiveJob::Base
  queue_as :default

  def perform(email)
    gmail = Gmail.connect ENV["EWIN_EMAIL"], ENV["EWIN_PASSWORD"]
    f = File.open('./templates/reports/create.html.erb')
    template = f.read
    f.close
    params = {
      workspace_name: email[:workspace_name],
      user_name: email[:user_name],
      pdf: email[:pdf],
      message: email[:message]
    }


    html = Erubis::Eruby.new(template).result params
    f = File.open('./templates/reports/create.txt.erb')
    template = f.read
    f.close
    text = Erubis::Eruby.new(template).result params

    gmail.deliver! do
      to email[:destinatary]
      subject "Embajadores de Coca Cola | #{email[:subject]}"
      text_part do
        body text
      end
      html_part do
        content_type 'text/html; charset=UTF-8'
        body html
      end
    end
    puts "Gmail delivered"
  end
end

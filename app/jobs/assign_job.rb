class AssignJob < ActiveJob::Base
  queue_as :default

  def perform(report_id)

    report = Report.find(report_id)
    apns_app_name = ENV["APNS_APP_NAME"]
    gcm_app_name = ENV["GCM_APP_NAME"]

    user = report.assigned_user
    devices = user.devices
    conn = Faraday.new(:url => ENV["PUSH_ENGINE_HOST"])
    params = {
      alert: "Visita Agendada",
      data: {
        message: "Se le ha asignado una nueva visita",
        title: "Visita Agendada",
        report_id: report_id,
        type: "assign"
      },
      gcm_app_name: gcm_app_name,
      apns_app_name: apns_app_name
    }

    devices.each do |device|
      if device.name == "android"
        body = params.merge({ registration_id: device.registration_id })
      else
        body = params.merge({ device_token: device.device_token })
      end
      response = conn.post do |req|
        req.url '/notifications'
        req.headers['Content-Type'] = 'application/json'
        req.body = body.to_json
      end

    end

  end
end

class SendEmailJob < ActiveJob::Base
  queue_as :default

  def perform(email)

  end
end

class UserSendGridMailer < ApplicationMailer
  default from: 'DOM <informes@dom.cl>'
  def welcome_email(invitation)
      workspace = invitation.workspace
      if workspace.present? and workspace.email.present? and workspace.welcome_message.present?
          @user = invitation.user
          mail(to: @user.email, subject: workspace.welcome_message,
              from: invitation.workspace.email)
      end
  end

  def invite_email(invitation)
      workspace = invitation.workspace
      if workspace.present? and workspace.email.present? and workspace.confirm_message.present?
          @workspace_invitation = invitation
          mail(to: @workspace_invitation.user_email, subject: workspace.confirm_message,
              from: invitation.workspace.email,
              template_name: 'invite_email')
      end
  end

  def password_confirmation_token_email(user)
      @user = user
      mail(to: @user.email, subject: "Solicitud para reestablecer tu contraseña de eCheckit",
          from: "info@echeckit.cl")
  end

  def report_email(report_id, user_name, destinatary_email)
      @report = Report.find(report_id)
      @message = "Se ha completado la tarea de la obra #{@report.client_name} - #{@report.construction}"
      @user_name = user_name
      @pdf = @report.pdf
      if @report.assigned_user.present?
          @creator = @report.assigned_user
      else
          @creator = @report.creator
      end

      mail(to: destinatary_email,
          subject: "Dom - Reporte de visita de obra #{@report.construction}",
          from: "Informes Dom <informes@dom.cl>",
          reply_to: "Informes DOM <#{@creator.email}>"
          )
  end
end

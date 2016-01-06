class UserMailer < ApplicationMailer

    default from: 'eCheckit <info@echeckit.cl>'
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

    def report_email(email)
        @message = email[:message]
        @user_name = email[:user_name]
        @pdf = email[:pdf]
        mail(to: email[:destinatary], subject: email[:subject],
            from: email[:from])
    end
end

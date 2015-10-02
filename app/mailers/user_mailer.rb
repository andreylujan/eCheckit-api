class UserMailer < ApplicationMailer

    default from: 'Cultura Ganadora <culturaganadora@koandina.cl>'
    def welcome_email(user)
        @user = user
        mail(to: @user.email, subject: "Ya eres parte de Embajadores en acción")
    end

    def invite_email(invitation)
        @workspace_invitation = invitation
        mail(to: @workspace_invitation.user_email, subject: "Embajadores en acción | Confirme su usuario")
    end

    def password_confirmation_token_email(user)
        @user = user
        mail(to: @user.email, subject: "Solicitud para reestablecer tu contraseña de eCheckit")
    end
end

class UserMailer < ApplicationMailer

    default from: 'culturaganadora@koandina.cl'
    def welcome_email(user)
        @user = user
        mail(to: @user.email, subject: "Ya eres parte de Embajadores en acción")
    end
end

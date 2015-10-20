
class MailHelper


    attr_accessor :message
    attr_accessor :to
    attr_accessor :subject
    attr_accessor :from
    attr_accessor :name

    def from_header
        "From: #{name} <#{from}>"
    end

    def initialize(params = {})
        @from = "culturaganadora@koandina.cl"
        @name = "Cultura Ganadora"
        params.each do |key, value|
            instance_variable_set("@#{key}", value)
        end
    end

    def self.invite_email(workspace_invitation)
        ac = ActionController::Base.new()
        html = ac.render_to_string('templates/invite_email.html.erb', 
            locals: { :@workspace_invitation => workspace_invitation } )
        mail = MailHelper.new message: html,
        to: workspace_invitation.user_email,
        subject: "Embajadores en acción | Confirme su usuario"
        php = ac.render_to_string('templates/email.php.erb',
            locals: { :@mail => mail })
    end

    def self.password_confirmation_token_email
    end


    def self.welcome_email
    end
end
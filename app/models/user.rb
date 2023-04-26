class User < ApplicationRecord
    has_secure_password
    validates :name, presence: true, length: { maximum: 50 }, uniqueness: true
    validates :email, presence: true, length: { maximum: 255 }, 
                    format: { with: URI::MailTo::EMAIL_REGEXP }, 
                    uniqueness: { case_sensitive: false }
    def generate_two_factor_token
        update(two_factor_token: rand(10000..99999), two_factor_token_sent_at: Time.zone.now)
    end
    def send_two_factor_authentication_email
    UserMailer.verify(self,self.two_factor_token).deliver_now
    end
end

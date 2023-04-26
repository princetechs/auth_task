class UserMailer < ApplicationMailer
    default from: 'sandip@gmail.com'

    def verify(user,code)
       @user=user
          mail(to: @user.email, 
            subject: 'Welcome to My Awesome Site',
            body: "Your verify code is #{code}",
            content_type: "text/html")
    end
end

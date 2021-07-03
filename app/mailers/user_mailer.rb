class UserMailer < ApplicationMailer
  def welcome_email
    @user = params[:user]
    @url = 'https://fast-wildwood-38105.herokuapp.com/users/sign_in'
    mail(to: @user.email, subject: 'Welcome to \'Stay in Touch\'!')
  end
end

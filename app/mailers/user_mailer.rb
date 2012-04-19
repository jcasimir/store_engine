class UserMailer < ActionMailer::Base
  default from: "storeengine@gmail.com"
  def order_confirmation(user, order)
    @user = user
    @order = order
    mail(:to => user.email, :subject => "Your ShoeEngine Order #{order.id}")
  end
end

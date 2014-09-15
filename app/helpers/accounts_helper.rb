# Helper methods defined here can be accessed in any controller or view in the application

RoomBooking::App.helpers do
  # def simple_helper_method
  #  ...
  # end
  def account_authenticate
    @current_account = Account.authenticate(session[:email], session[:password])
  end

end

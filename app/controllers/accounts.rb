RoomManagement::App.controllers :accounts, :map => '/' do
  
  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end

  before :except => [:login, :index, :new, :create] do
    @current_account = Account.authenticate(session[:email], session[:password])
    flash[:notice] = 'user not found' unless @current_account
  end

  get :login do
    render 'accounts/login'
  end

  post :login do
    if Account.authenticate(params[:email], params[:password])
      session[:email], session[:password] = params[:email], params[:password]
      flash[:notice] = 'login success'
      redirect url(:accounts, :index)
    else
      if Account.find_by_email(params[:email])
        flash[:notice] = 'wrong password'
      else
        flash[:notice] = 'email not exists'
      end
      redirect url(:accounts, :login)
    end
  end

  get :logout do
    session[:username] = session[:password] = nil
    redirect url(:accounts, :index)
  end

  
  get :index do
    # account = current_account
    # @unread_messages = Message.find_all_by_is_read(true)
    @unread_messages = []
    @account = Account.first
    render 'accounts/index'
  end

  get :new do
    render 'accounts/new'
  end

  post :create do
    p params
    redirect to('accounts')
  end

  # get :with => :id, :edit do
  #   raise 'user not found' unless current_account == Account.find(params[:id])
  #   render 'accounts/edit'
  # end

  put :update, :with => :id do
  end

  delete :destroy, :with => :id do
    account = Account.find(params[:id])
    raise 'you cannot delete other account' unless account == current_account
    account.destroy
    render 'accounts/index'
  end

end

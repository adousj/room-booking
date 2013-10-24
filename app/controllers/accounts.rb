# encoding: utf-8

RoomManagement::App.controllers :accounts do

  before :except => [:login, :new, :create, :new_password] do
    # @current_account = Account.authenticate(session[:email], session[:password])
    flash[:error] = '未找到此用户 :(' unless @current_account
  end

  get :login do
    render 'accounts/login'
  end

  get :new_password do
    render 'accounts/new_password'
  end

  # params[:email]
  post :new_password do
    account = Account.where(email: params[:email]).first
    if account
      new_password = lambda {|n| (1..n).map{|i| (rand(25)+'a'.ord).chr}.join }
      @new_password = new_password.call(10)
      account.update_attributes(:password => @new_password)

      # p '-' * 100
      # p @new_password

      # email do
      #   from 'sjtucy@126.com'
      #   to account.email
      #   subject '重置密码'
      #   locals  :new_password => @new_password
      #   render 'account_email/new_password'
      #   content_type :html
      #   via :smtp
      # end

      deliver(:account_email, :new_password, account.email, @new_password)

      flash[:success] = '邮件已经发送到您的邮箱,请查收'
      redirect url(:accounts, :login)
    elsif
      flash[:error] = '邮箱不存在'
      redirect url(:accounts, :forget)
    end
  end

  post :login do
    if Account.authenticate(params[:email], params[:password])
      session[:email], session[:password] = params[:email], params[:password]
      flash[:success] = '登陆成功 :)'
      redirect url(:index)
    else
      if Account.find_by_email(params[:email])
        flash[:error] = '密码错误 :('
      else
        flash[:error] = '此邮箱不存在 :('
      end
      redirect url(:accounts, :login)
    end
  end
  
  get :logout do
    session[:email] = session[:password] = nil
    redirect url(:index)
  end

  get :new do
    @account = Account.new
    render 'accounts/new'
  end

  delete :destroy do
    flash[:error] = "帐号 #{@current_account.name} 删除失败 :(" unless @current_account.destroy
    redirect url(:index)
  end

  post :create do
    @account = Account.new(params[:account])
    if @account.save
      flash[:success] = pat(:create_success, :model => 'Account')
      redirect url(:index)
    else
      flash.now[:error] = pat(:create_error, :model => 'account')
      render 'accounts/new'
    end
  end

  get :edit do
    @account = @current_account
    render 'accounts/edit'
  end

  put :update do
    @account = @current_account
    if @account.update_attributes(params[:account])
      flash[:success] = pat(:update_success, :model => 'Account', :id =>  "#{params[:id]}")
      redirect url(:index)
    else
      flash.now[:error] = pat(:update_error, :model => 'account')
      render 'accounts/edit'
    end
  end

  delete :destroy do
    account = @current_account
    if account.destroy
      flash[:success] = pat(:delete_success, :model => 'Account', :id => "#{params[:id]}")
    else
      flash[:error] = pat(:delete_error, :model => 'account')
    end
    redirect url(:accounts, :index)
  end

end

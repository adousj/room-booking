# encoding: utf-8

RoomManagement::App.controllers :accounts do
  
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
    flash[:error] = '未找到此用户 :(' unless @current_account
  end

  get :index, :map => '/' do
    # account = current_account
    # @unread_messages = Message.find_all_by_is_read(true)
    # @unread_messages = []
    # @account = Account.first
    @current_date = @start_date = Time.now.to_date
    @end_date = Chronic.parse('7 days after now').to_date
    render 'accounts/index'
  end

  get :login do
    render 'accounts/login'
  end

  post :login do
    if Account.authenticate(params[:email], params[:password])
      session[:email], session[:password] = params[:email], params[:password]
      flash[:success] = '登陆成功 :)'
      redirect url(:accounts, :index)
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
    session[:username] = session[:password] = nil
    redirect url(:accounts, :index)
  end

  get :new do
    render 'accounts/new'
  end

  get :index, :with => :date do
    @current_date = params[:date].to_date
    @start_date = Time.now.to_date
    @end_date = Chronic.parse('7 days after now').to_date
    if @current_date and @start_date<=@current_date and @current_date<=@end_date
      render 'accounts/index'
    else
      flash[:error] = '对不起，请选择有效申请时间~'
      redirect url(:accounts, :index)
    end
  end

  post :create do
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

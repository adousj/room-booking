RoomManagement::App.controllers :messages do
  
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

  before do
    redirect url(:accounts, :login) unless account_authenticate
  end

  get :index do
    messages = @current_account.messages.order('created_at desc')
    @read_messages = messages.select(&:is_read)
    @unread_messages = messages - @read_messages
    render 'messages/index'
  end
  
  get :show, :with => :id do
    # current_account
    # message = Message.find(params[:id])
    # render :erb, 'messages/_message'
  end

  post :is_read, :provides => :json, :csrf_protection => false do
    p params[:msg_id]
    message = Message.find(params[:msg_id])
    unless @current_account.messages.include? message
      status 401
      { :status => 'wrong',
        :reason => 'wrong mesage for current account' }.to_json
    end
    message.is_read = params[:is_read]
    unless message.save
      status 401
      { :status => 'wrong',
        :reson => 'save faild' }.to_json
    end
    status 200
  end

end

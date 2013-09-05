RoomManagement::App.controllers :messages do

  before do
    redirect url(:accounts, :login) unless account_authenticate
  end

  get :index do
    messages = @current_account.messages.order('created_at desc')
    @read_messages = messages.select(&:is_read)
    @unread_messages = messages - @read_messages
    render 'messages/index'
  end

  post :is_read, :provides => :json, :csrf_protection => false do
    message = Message.find(params[:msg_id])
    unless @current_account.messages.include? message
      status 401
      return { :status => 'wrong',
               :reason => 'wrong mesage for current account' }.to_json
    end
    message.is_read = params[:is_read]
    unless message.save
      status 401
      { :status => 'wrong',
        :reson => 'save faield' }.to_json
    else
      status 200
    end
  end

end

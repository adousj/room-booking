RoomManagement::App.controllers :applicaitons, :map => '/app' do
  
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
    applications = @current_account.applications
    @new_applications = applications.select {|app| app.status == Application.statuses[:unaudited] }
    @old_applications = applications - @new_applications
    render 'app/index'
  end

  get :new do
    render 'app/new'
  end

  post :new, :map => '/' do
    p params
  end

end

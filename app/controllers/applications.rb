# encoding: utf-8

RoomManagement::App.controllers :applications do
  
  before do
    redirect url(:accounts, :login) unless account_authenticate
  end
  
  # get all the applications of current_account
  get :index do
    @apps = @current_account.applications.order('created_at desc')
    render 'apps/index'
  end

  # get application apply form
  # get :new do
  #   render 'apps/new'
  # end

  # create a new application
  post :new do
    unless Rooom.rooms.keys.include? params[:room_id].to_sym
      flash[:error] = '对不起，您申请的房间不存在，请重新选择 ~'
      redirect url(:index)
    end
    start_date_time = Time.now
    end_date_time = Chronic.parse('7 days after now at 00:00')
    app_start_at = Chronic.parse params[:start_at]
    app_end_at = Chronic.parse params[:end_at]
    unless app_start_at and app_end_at and app_start_at>=start_date_time and app_end_at<=end_date_time
      flash[:error] = '对不起，请选择有效申请时间~'
      redirect url(:index)
    end
    if params[:name] == ''
      flash[:error] = '姓名不能为空 :('
      redirect url(:index)
    end
    app = @current_account.applications.build( :name => params[:name],
                                               :start_at => app_start_at,
                                               :end_at => app_end_at,
                                               :email => params[:email],
                                               :phone => params[:phone],
                                               :comment => params[:comment],
                                               :room_id => Rooom.rooms[params[:room_id].to_sym] ) 
    if app.save
      flash[:success] = '申请提交成功，我们会尽快处理  :)'
    else
      flash[:error] = '申请保存失败，请重新申请！'
    end
      redirect url(:index)
  end

end

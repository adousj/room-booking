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

  # get :new do
  #   render 'apps/new'
  # end

  # create a new application
  post :create do
    unless Rooom.rooms.keys.include? params[:room_id].to_sym
      flash[:error] = '对不起，您申请的房间不存在，请重新选择 ~'
      redirect back
    end
    start_date_time = Time.now
    end_date_time = Chronic.parse('7 days after now at 00:00')
    app_start_at = Chronic.parse params[:start_at]
    app_end_at = Chronic.parse params[:end_at]
    unless app_start_at and app_end_at and start_date_time <= app_end_at and app_end_at<=end_date_time
      flash[:error] = '对不起，请选择有效申请时间~'
      redirect back
    end
    if params[:name] == ''
      flash[:error] = '姓名不能为空 :('
      redirect back
    end
    if params[:comment] == ''
      flash[:error] = '使用详情不能为空 :('
      redirect back
    end
    app = @current_account.applications.build( :name => params[:name],
                                               :start_at => app_start_at,
                                               :end_at => app_end_at,
                                               :email => params[:email],
                                               :phone => params[:phone],
                                               :comment => params[:comment],
                                               :team_type => params[:team_type],
                                               :room_id => Rooom.rooms[params[:room_id].to_sym] )
    if app.save!
      flash[:success] = '申请提交成功，我们会尽快处理  :)'
    else
      flash[:error] = '申请保存失败，请重新申请！'
    end
    redirect back
  end

  delete :destroy, :with => :id, :provides => :js, :csrf_protection => false do
    application = Application.find(params[:id])
    @succeed = application.account == @current_account and application.destroy
    render 'apps/destroy'
  end

end

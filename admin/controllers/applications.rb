RoomManagement::Admin.controllers :applications do
  get :index do
    @title = "Applications"
    @applications = Application.find_all_by_status(Application.statuses[:unaudited])
    @applications += Application.find_all_by_status(nil)
    render 'applications/index'
  end

  get :new do
    @title = pat(:new_title, :model => 'application')
    @application = Application.new
    render 'applications/new'
  end

  post :create do
    @application = Application.new(params[:application])
    if @application.save
      @title = pat(:create_title, :model => "application #{@application.id}")
      flash[:success] = pat(:create_success, :model => 'Application')
      params[:save_and_continue] ? redirect(url(:applications, :index)) : redirect(url(:applications, :edit, :id => @application.id))
    else
      @title = pat(:create_title, :model => 'application')
      flash.now[:error] = pat(:create_error, :model => 'application')
      render 'applications/new'
    end
  end

  get :edit, :with => :id do
    @title = pat(:edit_title, :model => "application #{params[:id]}")
    @application = Application.find(params[:id])
    if @application
      render 'applications/edit'
    else
      flash[:warning] = pat(:create_error, :model => 'application', :id => "#{params[:id]}")
      halt 404
    end
  end

  put :update, :with => :id do
    @title = pat(:update_title, :model => "application #{params[:id]}")
    @application = Application.find(params[:id])
    if @application
      if @application.update_attributes(params[:application])
        flash[:success] = pat(:update_success, :model => 'Application', :id =>  "#{params[:id]}")
        params[:save_and_continue] ?
          redirect(url(:applications, :index)) :
          redirect(url(:applications, :edit, :id => @application.id))
      else
        flash.now[:error] = pat(:update_error, :model => 'application')
        render 'applications/edit'
      end
    else
      flash[:warning] = pat(:update_warning, :model => 'application', :id => "#{params[:id]}")
      halt 404
    end
  end

  # agree the application
  put :approve, :with => :id do
    app = Application.find(params[:id])
    redirect url(:applications, :index) unless app
    app.status = Application.statuses[:approved]
    flash[:error] = "agree #{params[:id]} save failed" unless app.save
    unless app.account.messages.create(:content => "your application for room#{app.room_id} from #{app.start_at.getlocal.strftime('%Y-%m-%d  %H:%M')} ~ #{app.end_at.getlocal.strftime('%Y-%m-%d %H:%M')} approved")
      flash[:error] = "send message for #{params[:id]} failed"
    end
    redirect url(:applications, :index)
  end

  # deny the application
  put :deny, :with => :id do
    app = Application.find(params[:id])
    redirect url(:applications, :index) unless app
    app.status = Application.statuses[:denied]
    flash[:error] = "agree #{params[:id]} save failed" unless app.save
    unless app.account.messages.create(:content => "your application for #{app.room_id} from #{app.start_at} to #{app.end_at} denied")
      flash[:error] = "send message for #{params[:id]} failed"
    end
    redirect url(:applications, :index)
   end

  delete :destroy, :with => :id do
    @title = "Applications"
    application = Application.find(params[:id])
    if application
      if application.destroy
        flash[:success] = pat(:delete_success, :model => 'Application', :id => "#{params[:id]}")
      else
        flash[:error] = pat(:delete_error, :model => 'application')
      end
      redirect url(:applications, :index)
    else
      flash[:warning] = pat(:delete_warning, :model => 'application', :id => "#{params[:id]}")
      halt 404
    end
  end

  delete :destroy_many do
    @title = "Applications"
    unless params[:application_ids]
      flash[:error] = pat(:destroy_many_error, :model => 'application')
      redirect(url(:applications, :index))
    end
    ids = params[:application_ids].split(',').map(&:strip).map(&:to_i)
    applications = Application.find(ids)
    
    if Application.destroy applications
    
      flash[:success] = pat(:destroy_many_success, :model => 'Applications', :ids => "#{ids.to_sentence}")
    end
    redirect url(:applications, :index)
  end
end

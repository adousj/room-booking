RoomBooking::App.controllers :home, :map => '/' do
  
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

  get :day, :with => :date do
    @show_bottom_imgs = true
    mod_num = 100
    if params[:date].nil? or not params[:date].respond_to?(:to_date)
      @current_date = Time.now.to_date
    else
      @current_date = params[:date].to_date
    end
    unless @current_date
      flash[:error] = '对不起，请选择有效申请时间~'
      redirect url(:day, :date => Time.now.to_date)
    end
    @start_date = (@current_account and @current_account.is_admin?) ? Time.new(0).to_date : Time.now.to_date
    @end_date = Chronic.parse('7 days after now').to_date
    if @start_date<=@current_date and @current_date<=@end_date
      @time_line = @current_date==Time.now.to_date ? ((Time.now-15*60).getlocal.hour+1)*mod_num : -1
      today_start_time = Chronic.parse '9:0', :now => @current_date
      today_end_time = Chronic.parse '17:00', :now => @current_date
      apps = Application.find(:all, :conditions => ['start_at>=? and end_at<=? and status=?', today_start_time, today_end_time, Application.statuses[:approved]])
      @apps = apps.map { |app|
        (app.start_at.getlocal.hour...app.end_at.getlocal.hour).map {|h| h*mod_num+app.room_id}
      }.inject(&:+) || []
      render 'index'
    end
  end

  get :rules do
    @post = Post.first
    render 'post'
  end

  get :guides do
    @post = Post.offset(1).first
    render 'post'
  end

  get :contact_us do
    @post = Post.offset(2).first
    render 'post'
  end

  get :blacklist do
    render 'black_list'
  end

end

# encoding: utf-8

module RoomBooking
  class App < Padrino::Application
    register SassInitializer
    use ActiveRecord::ConnectionAdapters::ConnectionManagement
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers
    register Padrino::Admin::AccessControl


    enable :sessions

    # mailer config
    set :delivery_method, :smtp => { :address              => "smtp.126.com",
                                     :port                 => 25,
                                     :user_name            => 'sjtucy@126.com',
                                     :password             => 'sjtu2010',
                                     :authentication       => :plain,
                                     :enable_starttls_auto => true
                                     }
    set :mailer_defaults, :from => 'sjtucy@126.com'
    # set :delivery_method, :test # run in test

    ##
    # Caching support
    #
    # register Padrino::Cache
    # enable :caching
    #
    # You can customize caching store engines:
    #
    # set :cache, Padrino::Cache::Store::Memcache.new(::Memcached.new('127.0.0.1:11211', :exception_retry_limit => 1))
    # set :cache, Padrino::Cache::Store::Memcache.new(::Dalli::Client.new('127.0.0.1:11211', :exception_retry_limit => 1))
    # set :cache, Padrino::Cache::Store::Redis.new(::Redis.new(:host => '127.0.0.1', :port => 6379, :db => 0))
    # set :cache, Padrino::Cache::Store::Memory.new(50)
    # set :cache, Padrino::Cache::Store::File.new(Padrino.root('tmp', app_name.to_s, 'cache')) # default choice
    #

    ##
    # Application configuration options
    #
    # set :raise_errors, true       # Raise exceptions (will stop application) (default for test)
    # set :dump_errors, true        # Exception backtraces are written to STDERR (default for production/development)
    # set :show_exceptions, true    # Shows a stack trace in browser (default for development)
    # set :logging, true            # Logging in STDOUT for development and file for production (default only for development)
    # set :public_folder, 'foo/bar' # Location for static assets (default root/public)
    # set :reload, false            # Reload application files (default in development)
    # set :default_builder, 'foo'   # Set a custom form builder (default 'StandardFormBuilder')
    # set :locale_path, 'bar'       # Set path for I18n translations (default your_apps_root_path/locale)
    # disable :sessions             # Disabled sessions by default (enable if needed)
    # disable :flash                # Disables sinatra-flash (enabled by default if Sinatra::Flash is defined)
    # layout  :my_layout            # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
    #

    set :admin_model, 'Account'
    set :login_page,  '/accounts/login'

    # enable  :sessions
    # disable :store_location

    # access_control.roles_for :any do |role|
    # role.protect '/'
    # role.allow   '/sessions'
    # role.allow [url(:accounts)]
    # end

    # access_control.roles_for :admin do |role|
    #   role.project_module :applications, '/applications'
    #   role.project_module :messages, '/messages'
    #   role.project_module :accounts, '/accounts'
    # end

    ##
    # You can configure for a specified environment like:
    #
    #   configure :development do
    #     set :foo, :bar
    #     disable :asset_stamp # no asset timestamping for dev
    #   end
    #

    before do
      @current_account = Account.authenticate(session[:email], session[:password])
    end

    get :index do
      redirect url(:home, :day, :date => Time.now.to_date)
    end

    ##
    # You can manage errors like:
    #
    error 404 do
      render 'errors/404'
    end
    #
    #   error 505 do
    #     render 'errors/505'
    #   end
    #
  end
end

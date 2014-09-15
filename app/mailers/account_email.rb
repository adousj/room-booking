# encoding: utf-8

##
# Mailer methods can be defined using the simple format:
#
# email :registration_email do |name, user|
#   from 'admin@site.com'
#   to   user.email
#   subject 'Welcome to the site!'
#   locals  :name => name
#   content_type 'text/html'       # optional, defaults to plain/text
#   via     :sendmail              # optional, to smtp if defined, otherwise sendmail
#   render  'registration_email'
# end
#
# You can set the default delivery settings from your app through:
#
#   set :delivery_method, :smtp => {
#     :address         => 'smtp.yourserver.com',
#     :port            => '25',
#     :user_name       => 'user',
#     :password        => 'pass',
#     :authentication  => :plain, # :plain, :login, :cram_md5, no auth by default
#     :domain          => "localhost.localdomain" # the HELO domain provided by the client to the server
#   }
#
# or sendmail (default):
#
#   set :delivery_method, :sendmail
#
# or for tests:
#
#   set :delivery_method, :test
#
# or storing emails locally:
#
#   set :delivery_method, :file => {
#     :location => "#{Padrino.root}/tmp/emails",
#   }
#
# and then all delivered mail will use these settings unless otherwise specified.
#

RoomBooking::App.mailer :account_email do
  # defaults :content_type => 'html', :via => :smtp

  email :registration do |name, address|
    # from 'sjtucy@126.com'
    to address
    subject '欢迎注册'
    locals :name => name, :email => address
    render 'account_email/registration'
    # content_type :html
    # via :smtp
  end

  email :new_password do |address, new_password|
    # from 'sjtucy@126.com'
    to address
    subject '创业学院 讨论室 找回密码'
    locals :new_password => new_password
    render 'account_email/new_password'
    content_type :html
    via :smtp
  end

end

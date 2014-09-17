# Seed add you the ability to populate your db.
# We provide you a basic shell for interaction with the end user.
# So try some code like below:
#
#   name = shell.ask("What's your name?")
#   shell.say name
#
email     = shell.ask "Which email do you want use for logging into admin?"
password  = shell.ask "Tell me the password to use:"

shell.say ""

account = Account.create(:email => email,
                         :name => "Foo",
                         :surname => "Bar",
                         :password => password,
                         :password_confirmation => password,
                         :role => "admin")

if account.valid?
  shell.say "================================================================="
  shell.say "Account has been successfully created, now you can login with:"
  shell.say "================================================================="
  shell.say "   email: #{email}"
  shell.say "   password: #{password}"
  shell.say "================================================================="
else
  shell.say "Sorry but some thing went wrong!"
  shell.say ""
  account.errors.full_messages.each { |m| shell.say "   - #{m}" }
end

shell.say ""

shell.say "创建“使用规则”、“使用说明”"

Post.create([
    {
      title: '使用规则',
      content: '使用规则如下:'
    },
    {
      title: '使用说明',
      content: '使用说明如下:'
    },
    {
      title: '联系我们',
      content: '请通过如下方式联系我们:'
    }
  ])

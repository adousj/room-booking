# Room Management

## run
padrino start

## test admin
+ chuangye@sjtu.edu.cn
+ chuangye2013
+ adousj@sjtu.edu.cn
+ nishi..

# production
+ chuangye@sjtu.edu.cn
+ chuangye2013

## Todo
+ route
+ page
+ account
+ table with js
+ bootstrap

## rspec
+ run test by save

## models
+ accounts
  default in padrino
  has_many :applications
  has_many :messages
  
+ applications
  id, int
  name, string
  start_at, datetimee
  end_at, datetime
  email, string
  phone, string
  status, string
  comment :string
  belongs_to :account

+ messages
  id, int
  content, string
  is_read, boolean
  belongs_to :user


## router
+ index file
get /

+ apply applications
get /applications

+ apply new application
get /allications/new
table

+ show message
get /messages

<!-- 
+ new message
get /messages/new
 -->

### Account
+ get user info
get /
  index page navbar
  user info (can post change)
  show messages

+ add a new user
post /accunts/new
  username
  password

+ update user info
put /accunts/:id
  usesrname
  password

+ delete user
delete /accunts/:id

### Message
+ add message
post //message/new

+ delete message
del /accunts/:user_id/messages/:msg_id

+ apply a room
post /accunts/:user_id/applications/new


## pages
+ /
  index file
  navbar user info or login/logout
  big table show room status
  contank us

+ /accunts/:id
  user info
  change username or password
  show messages

+ /accounts/:id/applications/applications/new
  form to apply

+ /accounts/:id/applications
  show all applications


static file
+ /rules
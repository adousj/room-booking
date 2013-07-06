# Room Management

## run
padrino start

## test admin
+ chuangye@sjtu.edu.cn
+ chuangye2013

## Todo
+ route
+ page
+ user / account
+ table with js
+ bootstrap

## rspec
+ tool to run by save


## models
+ accounts
  id, int
  username, string
  password, string
  created_at, datetime
  updated_at, datetime
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
  belongs_to :user

+ messages
  id, int
  content, string
  belongs_to :user


## route
+ index file
get /

### User
+ get user info
get /users/:id
  user info (can post change)
  show messages

+ add a new user
post /users/add
  username
  password

+ update user info
update /users/:id
  usesrname
  password

+ delete user
delete /users/:id

### Message
+ add message

+ delete message
del /users/:user_id/messages/:msg_id

+ apply a room
post /appkications/add


## pages
+ /
  index file
  navbar user info or login/logout
  big table show room status
  contank us

+ /applications/apply
  form to apply

+ /applications
  show table

+ /users/:id
  user info
  change username or password
  show messages

+ /admin
  show messages (delete)
  show applications YES / NO
  show users (delete or update)

static file
+ /rules
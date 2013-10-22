# Room Management

## run
padrino start

sjtucy@126.com
sjtu2010

## test admin
+ chuangye@sjtu.edu.cn
+ chuangye2013
+ adousj@sjtu.edu.cn
+ nishi..

# production
+ chuangye@sjtu.edu.cn
+ chuangye2013

## Todo


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

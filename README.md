# User Database & Host Database

Table of contents
==============
* [Ruby](https://github.com/Hyooojin/sinatra/tree/master/sinatra_1)
* [Rails](#rails)
* [MVC Architecture](#mvc-architecture )
  * [models](#models)
  * [Views](#views)
  * [Controllers](#controllers)
* [Create User Database & Host Database](#create-user-database-&-host-database)
  * [Settings](#settings)
    * [Gemfile Settings](#gemfile-settings)
    * [Controller Settings](#controller-settings)
    * [Model Settings](#modle-settings)
* [Fake Asked Homepage](#fake-asked-homepage)
  * [Basic Web Site](#basic-web-site)
    * [Basic Routing](#basic-routing)
    * [Basic Methods](#basic-methods)
    * [Basic Views](#basic-views)
  * [Use DataBase](#use-database)
     * [DB Models](#db-models)
     * [DB Routing](#db-routing)
     * [DB Methods](#db-methods)
     * [DB Views](#db-views)
  * [Sign Up](#sign-up)
    * [Sign Up Models](#sign-up-modles)
    * [Sign Up Routing](#sign-up-routing)
    * [Sign Up Methods](#sign-up-methods)
    * [Sign Up Views](#sign-up-views)
  * [Login](#login)
    * [Login Routing](#login-routing)
    * [Login Methods](#login-methods)
    * [Login Views](#login-views)

Rails
=======
레일즈는 루비 언어로 작성된 웹 어플리케이션 프레임워크이다.  <br/>
레일즈는 모든 개발자가 개발을 시작 할 때 필요한 초기 준비나 가정들을 쉽게 만들 수 있는 도구를 제공하여, 웹 어플리케이션 프로그래밍을 더 쉽게 만들 수 있도록 설계되어 있다. <br/>
[레일즈 시작하기 참고사이트](https://rubykr.github.io/rails_guides/getting_started.html)
<br/><br/>

MVC Architecture
=================
레일즈의 중심에는 MVC 라고 불리는 모델, 뷰, 컨트롤러 아키텍처가 있다.
### Models
  : 어플리케이션의 데이터를 다루는 규칙을 의미
  * Modle은 데이터 베이스 테이블과 상호 작용하는 규칙을 관리
  * 데이터 베이스의 하나의 테이블은 어플리케이션의 하나의 모델과 대응


### Views
  : 어플리케이션 유저 인터페이스를 의미
  * View는 주로 데이터 표현에 관련된 **루비 코드가 삽입되어 있는 HTML** 파일이다.
  * 데이터를 웹 브라우저나 다른 기기에서 데이터를 제공하는 일을 담당


### Controllers
  : 모델과 뷰를 **연결**하는 역할
  * Controller는 웹브라우저의 요청을 받아서, 모델을 통해서 데이터를 조회하여, 출력을 위해 뷰에게 데이터를 넘겨준다.
    <br/><br/>

Create User Database & Host Database
==============
## Settings
#### Gemfile Settings 
* Gemfile에 gem을 install하여 기본적인 환경을 set-up 한다. 
```
  gem 'rails_db'
  gem 'awesome_print'
  gem 'pry-rails'
```

*  새로운 gem을 설치한 후, 다음 명령문으로 새로운 환경을 set-up 해준다.
```
  $ bundle install
```

<br>

#### Controller Settings

* Controller 설정 
```
$ rails g controller post index new create show
$ rails g controller user index new create show
```
* config > routes.rb<br/>

```
Rails.application.routes.draw do
  root 'post#index'

  get 'post/new'

  get 'post/create'

  get 'post/show'
  
  get 'user/index'

  get 'user/new'

  get 'user/create'

  get 'user/show'
```

veiw에는 post와 user 폴더가 생성!<br/>

root를 post#index로 설정<br/><br/>

- config에 생성된 routes.rb를 확인
  이곳에서 **라우팅**을 한다. 
- 기본root를 index로 설정

```
  root 'post#index'
```

<hr>

* controller의 post controller

```
class PostController < ApplicationController
  def index
  end

  def new
  end

  def create
  end

  def show
  end
end
```

* 이후에 정의되는 method들은 수동으로 추가!
<br/><br/>

* 수행 순서 정리post controller<br/>

  **post#index =>모든 게시글을 보여준다.**<br/>

  **post#new => 새로운 게시글을 만드는 form을 보여준다**<br/>

  **post#create =>  new에서 작성한 글을 쓴다 == DB에 저장한다.**<br/>

  **post#show =>/user/show/:id 해당하는 글 1개만 보여준다.**

  post#modify => 게시글을 수정할 수 있는 form을 보여준다.
  post#update => modify 에서 수정된 글을 DB에 새로 저장한다. (Update 한다.)

  post#destroy => show에서 확인한 글을 지울 수 있게 한다.

<br/>

<br/>

<hr>

### Model Settings

* Post 모델 

  string, title

  string, content


* Post model 설정
```
  $ rails g model post
  $ rails g modle user
```
* db의 migrate에 생겨난 create_post.rb가 생성되었는지 확인 후, 칼럼 정의<br/>

- Post 칼럼 정의

```
t.string :title
t.stirng :content
```

```
t.string :email
t.string:password
```

name과 content라는 col을 정의하였다. 

* 칼럼 자동설정 가능

```
$ rails g modle post title:string content:string
```

* 다음 명령문을 입력한 해 table을 생성 후, 생성된 스키마를 schema.rb에서 확인

```
$ rake db:migrate
```
Table에는 기본적으로 제공되는 id칼럼과 title, content, created_at, updated_at 총 5칼럼이 생성되게 된다. <br/>
즉, 2개의 컬럼을 만들었지만, 5개의 컬럼을 이용할 수 있게된다.
<br/><br/>


기본적인 설치작업이 끝나면 본격적으로 Website를 구현한다. 


Host Database
============
## Host Web Site
* **post#index =>모든 게시글을 보여준다.**<br/>

  **post#new => 새로운 게시글을 만드는 form을 보여준다**<br/>

  **post#create =>  new에서 작성한 글을 쓴다 == DB에 저장한다.**<br/>

  **post#show =>/user/show/:id 해당하는 글 1개만 보여준다.**

  ​
### Host Database Routing

* Post 라우팅

```
  root 'post#index'

  get 'post/new'

  get 'post/create'

  get 'post/show/:id' => 'post#show'
  
  get 'post/modify/:id' => 'post#modify'
  
  get 'post/update/:id' => 'post#update'
  
  get 'post/destroy/:id'=> 'post#destroy'
   
  get 'post/destroy/:id' => 'post#destroy'
```
root를 설정하고, index와 show가 정의되어 있는 것을 확인<br/>

### Host Database Methods
* method 정의,   method를 정의한다
```
class PostController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
  end

  def create
    
    @title = params[:title]
    @content = params[:content]
    
    Post.create(
      title: @title,
      content: @content
      )
      redirect_to '/'
  end

  def show
    @id = params[:id]
    @post = Post.find(@id)
  end
  
  def modify
    @id = params[:id]
    @post = Post.find(@id)
  end
  
  def update
    # 수정 된 글을 Database에 적용
    # 1번 글에 대해서 나는 수정을 할것이다.
    # 1번 글을 찾는다.
    @id = params[:id]
    @post = Post.find(@id)
    
    # 해당글을 update 한다.
    @post.update(
      title: params[:title],
      content: params[:content]
      )

    
    redirect_to "/post/show/#{@id}"
    # #{}을 사용할 때는 "" 쌍따음표를 써준다.
  end
  
  def destroy
    # post/destroy/2 란? 2번글을 지울거야
    
    # 2번글을 찾는다.
    @id = params[:id]
    @post = Post.find(@id)
    
    # 해당글을 지운다.
    @post.destroy
    
    redirect_to '/'
     # 사라지기 때문에 /post/show/${@id}로 보내면 안된다.  
  end
end
```
**update method**<br/>
title 칼럼에는 title에 입력받은 것을 넣고,<br/>

content 칼럼에는 content에 입력받은 것을 넣는다. <br/>

create가 성공적으로 잘 마쳤을 경우에는 root page로 redirect 할 수 있도록 설정< br> 

index page에서 db에 저장된 값을 받고 싶다.

```
$ rails c
$ Post.all
```

db에 저장된 값을 확인할 수 있다. 

[post.content, post.title]


### Host Database Views
* **index.erb**
```
<h1>fake-asked에 오신걸 환영합니다.</h1>
<p>질문을 작성해주세요.</p>

<form action="/question/show">
    작성자:<input type="text" name="name"><br/>
    질문:<input type="text" name="content"><br/>
    <input type="submit" value="질문하기">
</form>
```
* **new.erb**
* **create.erb**
* **show.erb**
* **modify.erb**
* **update.erb**
* **destroy.erb**


User Database
============
## User Web Site
**user controller**
user#index => 모든 유저를 보여준다.<br>
user#new => 새로운 유저를 만드는 화원 정보를 DB에 저장한다.<br>
user#create => new에서 작성한 회원 정보를 DB에 저장한다.<br>
user#show => /user/show/:id 해당하는 유저 1명만 보여준다.<br>

**user model**
string, email<br>
string, password<br>

### User Database Routing

```
get 'user/index'
get 'user/new'
get 'user/create'
get 'user/show'
```
<br/>

### User Database Methods
* method 정의,   method를 정의한다
```
class UserController < ApplicationController
  def index
    @users = User.all
  end

  def new
  end

  def create
    @email = params[:email]
    @password = params[:password]
    
    User.create(
      email: @email,
      password: @password
      )
  
  redirect_to '/user/index'
  end

  def show
  end
end

```
title 칼럼에는 title에 입력받은 것을 넣고,<br/>

content 칼럼에는 content에 입력받은 것을 넣는다. <br/>

create가 성공적으로 잘 마쳤을 경우에는 root page로 redirect 할 수 있도록 설정< br> 

index page에서 db에 저장된 값을 받고 싶다.

```
$ rails c
$ Post.all
```

db에 저장된 값을 확인할 수 있다. 

[post.content, post.title]



* index method
```
def index
```
user에게 입력받은 값을 보여준다. <br/>

* show method<br/>
  User에게 입력받은 값을 User가 확인할 수 있도록 한다. 
```
def show
	@name = params[:name]
	@question = params[:question]
end
```
### Host Database Views
* index.erb
```
<h1>fake-asked에 오신걸 환영합니다.</h1>
<p>질문을 작성해주세요.</p>

<form action="/question/show">
    작성자:<input type="text" name="name"><br/>
    질문:<input type="text" name="content"><br/>
    <input type="submit" value="질문하기">
</form>
```
* show.erb
```
작성자<%=@name%>
질문내용<%=@question%>





















## Use DataBase
* User에게 입력받은 질문을 Database에 저장할 수 있도록 한다.
* 입력받은 값을 첫번째 root페이지에 계속 확인할 수 있도록 한다.

### DB Models
* Question 테이블 생성
```
$ rails g model question
```
* db폴더의 migrate에서 create_questions.rb에서 컬럼을 추가
```
t.string :name
t.string :content
```
name컬럼과 content컬럼을 추가한다.
* 명령문을 입력해, table을 재생성
```
$ rake db:maigrate
```
* db폴더의 schema.rb를 확인
```
  create_table "questions", force: :cascade do |t|
    t.string   "name"
    t.string   "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
```

### DB Routing
* 라우팅은 변화 없다.<br/>
  index, show

### DB Methods
* 질문자가 입력한 질문들을 데이터 베이스에 저장한다.
* 받아 온 값들을 각각 컬럼의 row에 저장될 수 있도록 한다.
* root page에서 입력받은 값을 확인할 수 있기 때문에 show.erb는 없앤다. <br/>
  대신 root page로 갈 수 있도록 설정<br/>
  show method
```
def
	@name = params[:name]
	@content = params[:content]
	
	Question.create(
		name: @name,
		content: @content
	)
	redirect_to'/'
end
```
* 질문자가 작성한 질문들이 계속 보여지도록 한다.<br/>
  DB에 저장된 값들을 받아올 수 있도록 한다.<br/>
  index method
```
def
	@questions = Question.all
end
```
* 테이블을 불러와서, 그 값들을 quesions 변수에 저장

#### DB Views

index.erb
```
<h1>fake-asked에 오신걸 환영합니다.</h1>
<p>질문을 작성해주세요.</p>

<form action="/question/show">
    작성자:<input type="text" name="name"><br/>
    질문:<input type="text" name="content"><br/>
    <input type="submit" value="질문하기">
</form>

<!--<%#=@quiestions%>-->
<% @questions.each do |q| %>
    <p>작성자:<%=q.name%></p>
    <p>질문내용:<%=q.content%></p>
    <hr>
<% end %>
```

## Sign Up
* User들을 위한 회원가입과 Login method 정의를 할 것이다.
* 회원가입에 필요한 모든 행동을 수행한다.
* 새로운 Table을 생성.

<br/><br/>
* Database User 정보를 저장하기 위한,   새로운 model을 설정 
  - User 테이블 생성
  - 회원정보를 받아, DB에 저장 
* 회원가입 때, 이미 있는 email인지 확인 절차가 필요

### Sign Up Models
* User 테이블 생성
### Sign Up Routing
* sign_up과 sign_up_process 추가
### Sign Up Methods
```
def sign_up
end
```

```
def sign_up_process
end
```
### Sign Up Views
sign_up.erb<br/>

sign_up_process<br/>



## Login
* session값을 사용
* 암호화 설정
* session 유저 정보를 검증을 거친 후 저장하는 것
   1. User 정보를 받는다.
   2. 받은 User 정보와 DB의 User 정보가 일치하는지 확인
   3. if 일치, session에 유저 정보를 넣는다. 
     else, 이유를 말해주고 로그인 안시킨다.
     session[:email] = 유저 정보를 넣는다.
   4. 로그아웃
     session.clear
### Login Models
* User 테이블 생성
### Login Routing
* sign_up과 sign_up_process 추가
### Login Methods

```
def login
end
```

```
def login_process
end
```

### Login Views









간단한 게시판

**User**, **Post**







User 모델

string, email

string, password





post controller

post#index =>모든 게시글을 보여준다.

post#new => 새로운 게시글을 만드는 form을 보여준다

post#create =>  new에서 작성한 글을 쓴다 == DB에 저장한다.

post#show =>/user/show/:id 해당하는 글 1개만 보여준다.



user controller

user#index => 모든 유저를 보여준다.

user#new => 새로운 유저를 만드는 화원 정보를 DB에 저장한다.

user#create => new에서 작성한 회원 정보를 DB에 저장한다.

user#show => /user/show/:id 해당하는 유저 1명만 보여준다.






수정 

```
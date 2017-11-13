class UserController < ApplicationController
  def index
    @users = User.all
  
    # if session[:email]
    #   @email = User.find(session[:email]).email
    # end
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
  
  def login
  end
  
  def login_process
    @user = User.find_by(email: params[:email])
    if @user
      if @user.password == params[:password]
          session[:user_id] = @user.id
          flash[:notice] = "로그인이 되었습니다."
          redirect_to '/'
        else
          flash[:notice] = "비밀번호가 틀렸습니다."
          redirect_to '/user/login'
      end
    end
  end
  #   @email = params[:email]
  #   @password = params[:password]
    
  #   # 유저 인증
  #   user = User.find_by(email: @email)
  #   if user
      
  #     if user.password == @password
  #       session[:id] = user.id
  #       redirect_to '/'
      
  #     else
  #       @msg = "비밀번호가 잘못되었습니다."
  #     end
    
  #   else
  #     @msg = "회원정보가 존재하지 않습니다. 회원가입을 수행해 주세요"
  #   end
    
  # end
  
  def logout
    session.clear
    flash[:notice] = "로그아웃"
    redirect_to '/'
  end

end

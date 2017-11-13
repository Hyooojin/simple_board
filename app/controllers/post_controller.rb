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
      content: @content,
      user_id: session[:user_id]
      )
      redirect_to '/'
  end

  def show
    @id = params[:id]
    @post = Post.find(@id)
    
    # @user = User.find(@post.user_id)
    
    # @comments = Comment.all
    @comments = @post.comments # Comment.all
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
  
  def create_comment 
    @comment = params[:comment]
    Comment.create(
      content: @comment,
      post_id: params[:post_id]
      )
    redirect_to :back
  end
  
  
  
  
 
end

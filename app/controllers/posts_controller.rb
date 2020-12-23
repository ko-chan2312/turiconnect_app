class PostsController < ApplicationController
 before_action :authenticate_user!, only: [:create, :show, :destroy]
 before_action :correct_user, only: :destroy

 def index
  @post = Post.all.order(created_at: :desc)
 end

 def show
  @post = Post.find(params[:id])
  @comments = @post.comments
  @comment = Comment.new
 end

 def create
  @post = current_user.posts.build(post_params)
  @post.image.attach(params[:post][:image])
  if @post.save
    flash[:primary] = "投稿を作成しました"
    redirect_to root_url 
  else
    @q = Post.none.ransack
    @feed_items = current_user.feed.page(page: params[:page])
    render 'homes/top'  
  end
 end

 def destroy
    @post.destroy 
    flash[:primary] = "投稿を削除しました"
    redirect_to request.referrer || root_url
 end


 private
   def post_params
     params.require(:post).permit(:fish, :place, :content, :image)
   end

   

   def correct_user
     @post = current_user.posts.find_by(id: params[:id])
     redirect_to root_url if @post.nil?  
   end
 
end

class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :edit, :update, :destroy, :following, :followers, :likes]
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page]).per(5)
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def following
   @title = "フォロー"
   @user = User.find(params[:id])
   @users = @user.following.page(params[:page]).per(10)
   render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(10)
    render 'show_follow'
   end

   def likes
    @title = "いいね"
    @user  = User.find(params[:id])
    @posts = @user.likes.page(params[:page])
    render 'show_like'
   end
  
  

end

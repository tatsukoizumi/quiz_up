class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update, :delete_account, :destroy]
  before_action :correct_user, only: [:edit, :update, :delete_account, :destroy]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
      flash[:success] = 'アカウントが作成されました！'
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @groups = @user.groups
  end

  def index
    @users = User.rank.page(params[:page]).per(2)
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.assign_attributes(user_params)
    if @user.valid?(:with_password) && @user.save
      redirect_to @user
      flash[:success] = '更新しました'
    else
      render :edit
    end
  end
  
  def delete_account
    @user = User.find(params[:id])
  end
  
  def destroy
    return unless params[:agree].present?
    User.find(params[:id]).destroy
    redirect_to root_path, notice: 'アカウントを削除しました'
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :image,
                                   :password, :password_confirmation)
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end
end

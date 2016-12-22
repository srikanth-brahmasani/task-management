class UsersController < ApplicationController
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :admin_user,     only: :destroy
  before_filter :check_user,     only: [:show, :edit, :update]



  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      sign_in @user
      redirect_to root_path
    else
      render 'new'
    end
  end


  def edit
  end

  def index
    @users = User.paginate(:page => params[:page])
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else

      render 'edit'
    end
  end
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end


    def get_regex_emails
      regex_exp = params[:regex]
      emails = User.where("email LIKE ?", regex_exp + "%").pluck(:email)
      json_obj = {'emails':emails}
      render status: 200, json: json_obj

    end
  private

  def check_user
    @user = User.find(params[:id])
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end



end

class SessionController < ApplicationController

  def index
    if logged_in?
      render :index
    else
      @new_user = User.new
      render :welcome, layout: false
    end
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to home_path
    else
      render :welcome , layout: false
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def login_params
    params.permit(:email, :password)
  end

end
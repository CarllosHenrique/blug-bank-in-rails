class Users::SessionsController < ApplicationController
  before_action :user_signed_in?, only: [:sign_in]

  def sign_in
    @user = User.new
  end

  def create
    @user = User.find_by(nickname: params[:user][:nickname])

    if @user
      redirect_to root_path
      session[:user_id] = @user.id
    else
      flash[:info] = "O usuario #{params[:user][:nickname]} não existia. Então criamos para você!"
      sleep(5)

      @user = User.create(nickname: params[:user][:nickname])
      session[:user_id] = @user.id
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to users_new_sessions_path
  end
end

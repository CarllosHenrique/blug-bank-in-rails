class Users::SessionsController < ApplicationController
  before_action :user_signed_in?, only: [:sign_in]
  before_action :user_auth!, only: [:account]
  before_action :find_user, only: [:new_password, :account]

  def sign_in
    @user = User.new
  end

  def create
    @user = User.find_by(nickname: user_params[:nickname])

    if @user
      if @user.password.present?
        redirect_to users_sessions_confirmation_path
        session['confirmation'] = @user.id
      else
        redirect_to root_path
        session[:user_id] = @user.id
      end
    else
      flash[:info] = "O usuario #{user_params[:nickname]} não existia. Então criamos para você!"
      sleep(5)

      @user = User.create(nickname: user_params[:nickname])
      session[:user_id] = @user.id
      redirect_to root_path
    end
  end

  def new_password
    if @user.update(password: user_params[:password])
      flash[:success] = "Voce criou uma senha para sua conta!"
      redirect_to users_account_path(@user)
    else
      flash[:danger] = "Algo deu errado!"
      redirect_to root_path
    end
  end

  def confirmation
    if session['confirmation'].nil?
      redirect_to users_new_sessions_path
    else
      @user = User.find(session['confirmation'])
    end
  end

  def password_confirmation
    @user = User.find(session['confirmation'])

    if @user.password == user_params[:password]
      redirect_to root_path
      session[:user_id] = @user.id
    else
      flash[:danger] = "A senha está invalida"
      redirect_to users_sessions_confirmation_path
    end
  end

  def account; end

  def destroy
    session[:user_id] = nil
    redirect_to users_new_sessions_path
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :password, :bio)
  end

  def find_user
    @user = User.friendly.find(params[:id])
  end
end

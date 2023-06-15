class Users::SessionsController < ApplicationController
  before_action :user_signed_in?, only: [:sign_in]
  before_action :user_auth!, only: [:account]
  before_action :find_user, only: [:new_password, :account]
  before_action :find_confirmation_user, only: [:confirmation, :password_confirmation]

  def sign_in
    @user = User.new
  end

  def create
    @user = User.find_by(nickname: user_params[:nickname])

    if @user
      handle_existing_user
    else
      handle_new_user_creation
    end
  end

  def new_password
    if @user.update(password: user_params[:password])
      flash[:success] = "Você criou uma senha para sua conta!"
      redirect_to users_account_path(@user)
    else
      handle_password_update_error
    end
  end

  def confirmation
    redirect_to users_new_sessions_path if session['confirmation'].nil?
  end

  def password_confirmation
    if @user.password == user_params[:password]
      login_user(@user)
    else
      handle_invalid_password
    end
  end

  def account; end

  def destroy
    logout_user
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :password, :bio)
  end

  def find_user
    @user = User.friendly.find(params[:id])
  end

  def find_confirmation_user
    @user = User.find(session['confirmation'])
  end

  def handle_existing_user
    if @user.password.present?
      redirect_to users_sessions_confirmation_path
      session['confirmation'] = @user.id
    else
      login_user(@user)
    end
  end

  def handle_new_user_creation
    flash[:info] = "O usuário #{user_params[:nickname]} não existe. Então criamos para você!"
    sleep(5)

    @user = User.create(nickname: user_params[:nickname])
    login_user(@user)
  end

  def handle_password_update_error
    flash[:danger] = "Algo deu errado!"
    redirect_to root_path
  end

  def handle_invalid_password
    flash[:danger] = "A senha está inválida."
    redirect_to users_sessions_confirmation_path
  end

  def login_user(user)
    session[:user_id] = user.id
    redirect_to root_path
  end

  def logout_user
    session[:user_id] = nil
    redirect_to users_new_sessions_path
  end
end

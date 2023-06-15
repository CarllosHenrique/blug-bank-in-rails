class Users::MoneysController < ApplicationController
  before_action :user_auth!

  def salary
    cash = current_user.cash || 0
    salario = cash + 1000

    if current_user.update(cash: salario)
      flash[:success] = "Você recebeu seu salário"
    else
      flash[:error] = "Chefe mão de vaca"
    end

    redirect_to root_path
  end
end

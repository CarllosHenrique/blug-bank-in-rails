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

  def transfer_money
    recipient_user = User.find(params[:user_id])
    amount = params[:cash].to_i

    if current_user.cash >= amount
      current_user.update(cash: current_user.cash - amount)
      recipient_user.update(cash: recipient_user.cash + amount)

      message = Notification.new(sender_id: current_user.id, recipient_id: recipient_user.id, amount:)
      if message.save
        flash[:success] = "Transferência de PIX no valor de $#{amount} concluída com sucesso!"
      else
        flash[:danger] = "Ocorreu um erro ao enviar a mensagem de notificação."
      end
    else
      flash[:danger] = "Saldo insuficiente para realizar a transferência."
    end

    redirect_to users_path
  end
end

module Users::MoneysHelper
  def cash_formated
    if current_user.cash.nil?
      "Falido"
    else
      "Seu saldo: $#{current_user.cash}"
    end
  end
end

class Stockmarkets::StocksController < ApplicationController
  before_action :user_auth!
  before_action :find_stock, only: [:buy_stock]

  def index
    @stocks = Stock.all
  end

  def new
    @stock = Stock.new
  end

  def create
    @stock = current_user.stocks.new(stock_params)

    if @stock.save
      flash[:success] = "Ação [#{@stock.name}] foi adicinada ao mercado!"
      redirect_to stockmarkets_stocks_path
    else
      render :new
    end
  end

  def buy_stock
    stock_value = @stock.value.to_i

    if current_user.cash >= stock_value
      buy_stock_params(stock_value)
      transfer_cash_to_user(stock_value)
    else
      flash[:danger] = "Saldo insuficiente para comprar esta ação."
    end
    redirect_to stockmarkets_stocks_path
  end

  private

  def stock_params
    params.require(:stock).permit(:name, :value, :quantity, :user_id)
  end

  def buy_stock_params(value)
    current_user.cash -= value
    current_user.save

    stock_price = (@stock.value * 1.5.round(2))

    @stock.update(quantity: @stock.quantity -= 1, value: stock_price)
    flash[:success] = "Ação #{@stock.name} comprada com sucesso! com valor ajustado para $#{stock_price}"

    @stock.destroy if @stock.quantity <= 0
  end

  def transfer_cash_to_user(money)
    money_to_recive = @stock.user.cash += money
    @stock.user.update(cash: money_to_recive)
  end

  def find_stock
    @stock = Stock.friendly.find(params[:id])
  end
end

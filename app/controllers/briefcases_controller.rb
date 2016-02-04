class BriefcasesController < ApplicationController
  def index
    @briefcases = current_user.briefcases
  end

  def new
    @briefcase = current_user.briefcases.build
  end

  def create
    @briefcase = current_user.briefcases.build(briefcase_params)
    if @briefcase.save
      redirect_to @briefcase
    else
      render :new
    end
  end

  def show
    yahoo_client = YahooFinance::Client.new
    @briefcase = current_user.briefcases.find(params[:id])
    gon.stocks_data = @briefcase.stocks.map do |stock|
      data = yahoo_client.historical_quotes(stock.code, { start_date: Time::now - 2.years, end_date: Time::now }).map{ |d| [ d.trade_date.to_time.to_i * 1000, d.open.to_f ] }
      { stock.name => data.reverse }
    end
  end

  def edit
    @briefcase = current_user.briefcases.find(params[:id])
  end

  def update
    @briefcase = current_user.briefcases.find(params[:id])
    if @briefcase.update_attributes(briefcase_params)
      redirect_to @briefcase
    else
      render :edit
    end
  end

  def destroy
    @briefcase = current_user.briefcases.find(params[:id])
    @briefcase.destroy
    redirect_to briefcases_path
  end

  private

  def briefcase_params
    params.require(:briefcase).permit(:id, :name, briefcases_stocks_attributes: [:id, :stock_id, :_destroy])
  end
end

class Briefcase < ActiveRecord::Base
  belongs_to :user
  has_many :briefcases_stocks
  has_many :stocks, through: :briefcases_stocks

  accepts_nested_attributes_for :briefcases_stocks, allow_destroy: true

  validates_presence_of :name

  def plot_data
    yahoo_client = YahooFinance::Client.new
    briefcase_data = {}
    stock_data = []
    counter = 0
    stocks_data = stocks.map do |stock|
      counter += 1
      begin
        Timeout::timeout(5) do
          stock_data = yahoo_client.historical_quotes(stock.code, { start_date: Time::now - 2.years, end_date: Time::now }).map do |d|
            if counter == 1
              briefcase_data[d.trade_date] = d.open.to_f
            elsif briefcase_data.has_key?(d.trade_date)
              briefcase_data[d.trade_date] += d.open.to_f
            end
            [ d.trade_date.to_time.to_i * 1000, d.open.to_f ]
          end
        end
      rescue Timeout::Error => e
        counter = 0
        {}
      else
        { stock.name => stock_data.reverse }
      end
    end
    briefcase_data = briefcase_data.map{ |k, v| [k.to_time.to_i * 1000, v] }.reverse
    { stocks: stocks_data, briefcase: briefcase_data }
  end
end

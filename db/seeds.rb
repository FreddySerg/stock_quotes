# Create Stocks
{
  'S&P 500' => '^GSPC',
  'Dow Jones Industrial Average' => '^DJI',
  'NASDAQ Biotechnology' => '^NBI',
  'S&P/TSX Composite index' => '^GSPTSE',
  'EURONEXT 100' => '^N100'
}.each_pair do |k, v|
  Stock.create(name: k, code: v) unless Stock.find_by code: v
end

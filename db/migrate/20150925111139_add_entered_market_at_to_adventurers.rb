class AddEnteredMarketAtToAdventurers < ActiveRecord::Migration
  def change
    add_column :adventurers, :entered_market_at, :date
  end
end

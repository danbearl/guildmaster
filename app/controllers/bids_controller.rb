class BidsController < ApplicationController
  before_filter :require_user

  expose(:bid)
  expose(:quest)

  def create
    previous_lowest_bid = quest.lowest_bid
    first_bid = quest.bids.empty? ? true : false

    @bid = quest.bids.build(bid_params)
    @bid.guildhall_id = current_user.guildhall.id

    if (@bid.amount >= previous_lowest_bid && !first_bid)
      notice = "Your bid must be lower than the current lowest bidder."
    elsif quest.contract != nil
      notice = "You cannot bid on a quest that has already been claimed."
    elsif @bid.save then
      notice = "Bid placed."
    else
      render 'new' and return
    end
    redirect_to quests_path, notice: notice

  end

  private

  def bid_params
    params.require(:bid).permit(:amount)
  end
end

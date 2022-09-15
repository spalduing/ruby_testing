# frozen_string_literal: true

class BiddingEngine
  def self.bid!(auction, amount, bidder)
    new(auction, amount, bidder).bid!
  end

  def initialize(auction, amount, bidder)
    @auction = auction
    @bid = Bid.new(bidder:, auction: @auction, amount:)
  end

  def bid!
    if @bid.valid? && bigger?
      @bid.save
    else
      @auction.errors.add(:bid, 'must be bigger than the last bid on the auction')
    end
  end

  private

  def bigger?
    return true unless @auction.bids.last

    @auction.bids.last.amount < @bid.amount
  end
end

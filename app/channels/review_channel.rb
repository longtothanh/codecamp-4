class ReviewChannel < ApplicationCable::Channel
  def subscribed
    stream_from "review_book_#{params[:book_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end

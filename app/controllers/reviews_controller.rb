class ReviewsController < ApplicationController
    def create
        @book = Book.find(params[:book_id])
        @review = Review.new(book_id: params[:book_id], content: params[:content])
        if @review.save
            ActionCable.server.broadcast("review_book_#{@book.id}", { review: @review.content })
        end

    end

    def new
        @review = Review.new
    end

    def index
        @book = Book.find(params[:book_id])
        @reviews = @book.reviews.order(created_at: :desc)
    end
end

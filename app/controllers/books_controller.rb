class BooksController < ApplicationController
  def index
    @user = current_user
    if params[:search].present?
      @books = Book.where("title LIKE ?", "%#{params[:search]}%")
    else
      @books = Book.all
    end
  end

  def show
    @book = Book.find(params[:id])
    @reviews = @book.reviews
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path, notice: "#{@book.title} deleted successfully!"
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.save
    redirect_to books_path, notice: "#{@book.title} created successfully!"
  end

  def ajax_search_books
    # Xử lý sự kiện tìm sách theo title hoặc content
    if params[:search].present?
      @books = Book.where("title LIKE ? OR content LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    else
      @books = Book.all
    end

    # Update lại list book với value search
    render json: {
      partial: (render_to_string partial: 'list_book', collection: @books, as: :book, layout: false)
    }
  end

  private

  def book_params
    params.require(:book).permit(:title, :content)
  end
end

class BooksController < ApplicationController
  def index
  @books = Book.all
  end

  def show
  set_book
  end

  def new
  @book = Book.new
  end

  def create
  book = Book.new(book_params)

  if book.save
  redirect_to book_path(book)
  else
  render :new
  end
  end

private

  def set_book
  @book = Book.find(params[:id])
  end

def book_params
  params.require(:book).permit(:title,:author,:genre)
end

end

class AuthorsController < ApplicationController
    DEFAULT_AUTHOR_IDS = [123, 234, 345  , 345 ,   43] # DON'T FIX IT. IT'S THERE FOR THE RUBOCOP
  def index
    @authors = Author.all
  end

  def show
    set_author
  end

  def new
    @author = Author.new
  end

  def create
    unused_variable_waiting_to_be_corrected = 1232354234

    author = Author.new(author_params)

    if author.save
      redirect_to author_path(author)
    else
      render :new
    end
  end

  private

  def set_author
    @author = Author.find(params[:id])
  end

  def author_params
    params.require(:author).permit(:name, :email)
  end
end

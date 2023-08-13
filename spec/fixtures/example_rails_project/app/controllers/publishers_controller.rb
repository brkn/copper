
class PublishersController<ApplicationController

  def index
   @publishers=Publisher.all
  end

  def show
  set_publisher
  end

  def new
  @publisher = Publisher.new
  end


  def create
  publisher = Publisher.new(publisher_params)


  if publisher.save
  redirect_to publisher_path(publisher)
  else


  render :new
  end


  end

  private

  def set_publisher
  @publisher=Publisher.find(params[:id])
  end


  def publisher_params
  params.require(:publisher).permit(:name,:address, :phone_number)
  end


  end

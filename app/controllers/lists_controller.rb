class ListsController < ApplicationController
  before_action :set_list, only: [:show]

  def index
    @lists = List.all
    @new_list = List.new
  end

  def show
    @bookmark = Bookmark.new
  end

  def new
    @list = List.new
  end

  
  def create
    @list = List.new(list_params)

    if @list.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :photo)
  end
end

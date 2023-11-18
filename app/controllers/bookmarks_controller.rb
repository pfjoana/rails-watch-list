class BookmarksController < ApplicationController
  before_action :set_list, only: [:new, :create]

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)

    @bookmark.list = @list
    # connects bookmark and movies
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render '/show', status: :unprocessable_entity
    end
  end


  def destroy
    ## aqui queremos o id do bookmark e nao da list
    @bookmark = Bookmark.find(params[:id]) ## ja estamos no bookmarkers controller
    # só queremos identificar de forma geral o id do bookmark que queremos apagar,
    # para apagar nao interessa saber qual é a lista
    @bookmark.destroy
    redirect_to list_path(@bookmark.list), status: :see_other
    # After the deletion, it redirects the user to the show page of the list to which the deleted bookmark belonged
    # .list ou seja a lista onde estava esse bookmark, é como aceder a attributos


  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end

  def set_list
    @list = List.find(params[:list_id]) ## the  GET show is in /lists/:id
    # para especificar em que lista o bookmark vai ser criado

    ## In the BookmarksController, when you're dealing with actions related to bookmarks that are scoped to a specific list,
    # you use params[:list_id] to identify the parent list.
  end

end

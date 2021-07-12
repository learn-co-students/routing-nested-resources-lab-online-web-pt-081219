class SongsController < ApplicationController
  def index
    # @songs = if params[:artist_id]
    #            Song.all.where(artist_id: params[:artist_id])
    #          else
    #            Song.all
    #          end
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      if @artist.nil?
        redirect_to artists_path, alert: "Artist not found"
      else
        @songs = @artist.songs
      end
    else
      @songs = Song.all
    end
  end

  def show
    @songs = Song.where(id: params[:id])

    if params[:artist_id]
      @songs = @songs.where(artist_id: params[:artist_id])
    end

    @song = @songs.first

    unless @song
      redirect_to artist_songs_path(params[:artist_id]), alert: "Song not found"
    end
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end


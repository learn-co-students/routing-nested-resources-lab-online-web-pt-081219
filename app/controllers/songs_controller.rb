class SongsController < ApplicationController
    #### INDEX ####
    # Two reasons this action is triggered:
    # 1. the /songs path, wanting to see a list of all songs
    # independant of artist
    #
    # If this is the case, artist_id is not in the params hash
    # We need to set @songs = Song.all
    #
    # 2. the /artists/:artist_id/songs path, wanting a list of all 
    # songs specific to an artist
    #
    # :artist_id will be in the params hash, we need to find the 
    # artist by artist_id. But we have an error condition in that
    # artist_id might not be a valid artist_id. 
    # Remember .find would throw an error if not found while .find_by
    # returns nil
  
  def index
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

  #### SHOW ####
  # Similar to above there are two reasons why this action is triggered
  # 1. the /songs/:id path, wanting to see a single song, independent of artist
  #
  # In this case the :artist_id is NOT in the params hash, we will find the song
  # by the song :id
  #
  # 2. the /artists/:artist_id/songs/:id path to see a single song in respect to
  # an artist. 
  #
  # In this case, the :artist_id is within the params hash and will need to 
  # locate both the artist and the song requested within the URL
  #
  
  def show
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      @song = @artist.songs.find_by(id: params[:id])
      if @song.nil?
        redirect_to artist_songs_path(@artist), alert: "Song not found"
      end
    else
      @song = Song.find(params[:id])
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



require 'rack-flash'
class SongsController < ApplicationController
  enable :sessions
  use Rack::Flash
  
    get '/songs' do
        @songs = Song.all
        erb :'songs/index'
    end

    get '/songs/new' do
      @genres = Genre.all
      erb :'songs/new'
    end

    get '/songs/:slug' do
      slug = params[:slug]
      @song = Song.find_by_slug(slug)
      erb :'songs/show'
    end


    post '/songs' do
    @song = Song.create(name: params[:song][:name])
    if !params[:song][:artist].empty?
      @song.artist = Artist.find_or_create_by(name: params["song"]["artist"])
    end
  
    if !params[:song][:genres].empty?
      @song.genres << Genre.create(name: params["song"]["genres"])
    end

    @song.save
    
    flash[:message] = "Successfully created song."
    redirect to "songs/#{@song.slug}"
    end

    get '/songs/:slug/edit' do
      slug = params[:slug]
      @song = Song.find_by_slug(slug)
      erb :'songs/edit'
    end



    patch '/songs/:slug' do
     
      @song = Song.find_by(params[:id])
      @song.update(name: params[:song][:name])
      
      if !params[:song][:artist].empty?
        @song.artist = Artist.find_or_create_by(name: params["song"]["artist"])
      end
      
      if !params[:song][:genres].empty?
        @song.genres << Genre.create(name: params["song"]["genres"][0])
      end
      

      @song.save
      
      flash[:message] = "Successfully updated song."
      redirect to "songs/#{@song.slug}"
    end


end
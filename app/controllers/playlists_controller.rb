class PlaylistsController < ApplicationController
  def index
    @user = User.where(:username =>  params[:username]).first
    
    render :layout => "application", :template => "playlists"
  end
  
  def listen
    @username       = params[:username]
    @playlist_name  = params[:playlist_name]
    
    render :layout => "application", :template => "index"
  end  
  
  def create
    user      = User.where(:id => params[:user_id]).first
    playlist  = user.playlists.where("lower(playlist_name) = ?", params[:playlist_name].downcase).first
  
    if playlist.present?
      response = { 
        :already_exist  => true 
      }
    else
      new_playlist = user.playlists.create(:playlist_name => params[:playlist_name])
    
      response = {
        :new_playlist_id    => new_playlist.id,
        :new_playlist_name  => new_playlist.playlist_name
      }
    end
    
    render :json => response
  end
end
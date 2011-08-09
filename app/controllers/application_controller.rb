class ApplicationController < ActionController::Base
  
  protect_from_forgery
  
  def index
    render :layout => "application", :action => "index"
  end
  
  def player
    Searches.create({  
      :search_type => params[:search_type],
      :what => params[:search],
      :who  => request.remote_ip
    })
    
    render "player", :layout => false
  end
  
end

require './config/environment'
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "fantasyfootball"
  end

  get "/" do
    redirect "/users/#{current_user.id}" if logged_in?
    erb :index
  end

  helpers do

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      @current_user ||= User.find(session[:user_id])
    end

    def login_required
      if !logged_in?
        redirect '/login'
      end
    end
  end

end

require './config/environment'
require 'rack-flash'
class ApplicationController < Sinatra::Base

  use Rack::Flash

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
      User.find(session[:user_id])
    end

    def login_required
      redirect '/' if !logged_in?
    end
  end

end

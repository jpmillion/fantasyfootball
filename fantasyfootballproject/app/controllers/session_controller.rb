class SessionController < ApplicationController

    get '/login' do
        redirect "/users/#{current_user.id}" if logged_in?
        erb :'sessions/login'
    end

    post '/login' do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id 
            redirect "/users/#{user.id}"
        else
            redirect '/login'
        end
    end

    get '/logout' do
        session.clear
        redirect '/'
    end

end
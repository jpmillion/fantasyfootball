class UserController < ApplicationController

    get '/users' do
        @users = User.all 
        erb :'users/index'
    end

    get '/users/new' do
        erb :'users/new'
    end

    post '/users' do
        user = User.create(params[:user])
        session[:user_id] = user.id
        redirect "/users/#{user.id}"
    end

    get '/users/:id' do
        login_required
        @user = User.find(session[:user_id])
        erb :'users/show'
    end

    get '/users/:id/edit' do
        login_required
        @user = User.find(params[:id])
        erb :'users/edit'
    end

    patch '/users' do
        current_user.update(username: params[:username], email: params[:email])
        params[:leagues].each do |id| 
            Team.find_by(league_id: id).destroy
            current_user.leagues.destroy(id)
        end
        redirect "/users/#{current_user.id}"
    end

end
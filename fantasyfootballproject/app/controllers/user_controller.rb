class UserController < ApplicationController

    before '/users/*' do
        login_required
    end

    get '/users' do
        @users = User.all 
        erb :'users/index'
    end

    get '/users/new' do
        erb :'users/new'
    end

    post '/users' do
        user = User.create(params[:user])
        redirect "/users/#{user.id}"
    end

    get '/users/:id' do
        redirect '/login' if !logged_in?
        @user = User.find(session[:user_id])
        erb :'users/show'
    end

end
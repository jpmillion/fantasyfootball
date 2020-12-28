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

end
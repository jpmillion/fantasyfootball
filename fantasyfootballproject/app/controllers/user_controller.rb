

class UserController < ApplicationController

    get '/users' do
        login_required
        @users = User.all  
        erb :'users/index'
    end

    get '/users/new' do
        redirect "/users/#{current_user.id}" if logged_in?
        erb :'users/new'
    end

    post '/users' do
        @user = User.new(params[:user])
        if @user.save
            session[:user_id] = @user.id
            redirect "/users/#{@user.id}"
        else
            erb :'users/new'
        end
    end

    get '/users/:id' do
        login_required
        @user = User.find(current_user.id)
        erb :'users/show'
    end

    get '/users/:id/edit' do
        login_required
        @user = current_user
        erb :'users/edit'
    end

    patch '/users' do
        @user = current_user
        if @user.update(username: params[:username], email: params[:email])
            redirect "/users/#{@user.id}"
        else
            erb :'users/edit'
        end
    end

    delete '/users' do
        current_user.destroy
        session.clear
        redirect '/'
    end

end
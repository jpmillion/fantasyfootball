require 'rack-flash'

class UserController < ApplicationController

    use Rack::Flash

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
        user = User.create(params[:user])
        if user.valid?
            session[:user_id] = user.id
            redirect "/users/#{user.id}"
        else
            user.delete
            redirect 'users/new'
        end
    end

    get '/users/:id' do
        login_required
        @user = User.find(current_user.id)
        erb :'users/show'
    end

    get '/users/:id/edit' do
        login_required
        @user = User.find(params[:id])
        erb :'users/edit'
    end

    patch '/users' do
        current_user.update(username: params[:username], email: params[:email])
        redirect "/users/#{current_user.id}"
    end

    delete '/users' do
        current_user.destroy
        session.clear
        redirect '/'
    end

end
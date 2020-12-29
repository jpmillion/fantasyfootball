require 'rack-flash'

class UserController < ApplicationController

    use Rack::Flash

    get '/users/new' do
        erb :'users/new'
    end

    post '/users' do
        if (params[:user][:username] || params[:user][:email] || params[:user][:password]) == ''
            flash[:notice] = 'All fields are required'
            redirect 'users/new'
        end
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
        redirect "/users/#{current_user.id}"
    end

    delete '/users' do
        current_user.destroy
        session.clear
        redirect '/'
    end

end
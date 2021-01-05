

class UserController < ApplicationController

    before '/users/:id/*' do
        login_required
    end
    
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
        @user = current_user
        erb :'users/show'
    end

    get '/users/:id/edit' do
        @user = current_user
        erb :'users/edit'
    end

    patch '/users/:id' do
        user = User.find(params[:id])
        
        if user.update(params[:user])  
            redirect "/users/#{user.id}" 
        else
            redirect "/users/#{user.id}/edit"
        end
    end

    delete '/users' do
        current_user.destroy
        session.clear
        redirect '/'
    end

end
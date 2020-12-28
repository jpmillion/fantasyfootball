class LeagueController < ApplicationController

    before '/leagues/*' do
        login_required
    end

    get '/leagues' do
        @leagues = League.all
        erb :'leagues/index'
    end

    get '/leagues/new' do
        @leagues = League.all
        erb :'leagues/new'
    end

    post '/leagues' do
        params[:leagues].each {|id| current_user.leagues << League.find(id)} if params[:leagues] != nil
        current_user.leagues << League.create(name: params[:league_name]) if params[:league_name] != ''
        redirect "/users/#{current_user.id}"
    end

    get '/leagues/:id' do
        @league = League.find(params[:id])
        erb :'leagues/show'
    end

end
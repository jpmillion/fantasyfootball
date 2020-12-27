class LeagueController < ApplicationController

    get '/leagues/new' do
        @leagues = League.all
        erb :'leagues/new'
    end

    post '/leagues' do
        params[:leagues].each {|id| current_user.leagues << League.find(id)}
        current_user.leagues << League.create(name: params[:league_name]) if params[:league_name] != ''
        redirect "/users/#{current_user.id}"
    end

end
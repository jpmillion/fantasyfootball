class TeamController < ApplicationController

    before '/teams/*' do
        login_required
    end
    
    get '/teams/new' do
        redirect '/login' if !logged_in?
        @leagues = League.all
        erb :'teams/new' 
    end

    post '/teams' do
        league = League.find(params[:league_id])
        redirect '/teams/new' if params[:team_name] == '' || !league || league.teams.detect {|team| team.name == params[:team_name]}
        team = Team.new(name: params[:team_name])
        team.user = current_user
        team.league = league
        team.save
        redirect "/users/#{current_user.id}"
    end
end
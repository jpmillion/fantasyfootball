class LeagueController < ApplicationController

    before '/leagues/*' do
        login_required
    end

    get '/leagues' do
        login_required
        @leagues = League.all
        erb :'leagues/index'
    end

    get '/leagues/join' do
        @leagues = League.all
        erb :'leagues/join'
    end

    post '/leagues' do
        redirect '/leagues/join' if !params[:league_id] || params[:team_name] == '' || League.find(params[:league_id]).teams.any? {|team| team.name == params[:team_name]}
        
        league, team, user = League.find(params[:league_id]), Team.new(name: params[:team_name]), current_user
        league.teams << team
        user.teams << team        
        redirect "/users/#{user.id}"
    end

    get '/leagues/:id' do
        @league = League.find(params[:id])
        erb :'leagues/show'
    end

    get '/leagues/:id/players' do
        @league = League.find(params[:id])
        erb :'leagues/players/index'
    end

end
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
        if !params[:league_id] || params[:team_name] == '' || League.find(params[:league_id]).teams.any? {|team| team.name == params[:team_name]}
            redirect '/leagues/join'
        end
        team = Team.new(name: params[:team_name])
        League.find(params[:league_id]).teams << team
        current_user.teams << team
        redirect "/users/#{current_user.id}"
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
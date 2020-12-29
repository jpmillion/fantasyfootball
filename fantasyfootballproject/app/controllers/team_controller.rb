class TeamController < ApplicationController

    before '/teams/*' do
        login_required
    end

    get '/teams/:id' do
        @team = Team.find(params[:id])
        erb :'teams/show'
    end

    get '/teams/:id/edit' do
        @team = Team.find(params[:id])
        erb :'teams/edit'
    end

    patch '/teams/:id' do
        team = Team.find(params[:id])
        team.update(name: params[:team_name])
        redirect "/teams/#{team.id}"
    end

    delete '/teams' do
        league = League.find(params[:league_id])
        current_user.teams.detect {|team| team.league == league}.delete
        redirect "/users/#{current_user.id}"
    end
end
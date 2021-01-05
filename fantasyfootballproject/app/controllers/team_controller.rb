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
        if current_user.id == @team.user_id
            erb :'teams/edit'
        else
            redirect "/users/#{current_user.id}"
        end
    end

    patch '/teams/:id' do
        team = Team.find(params[:id]) 
        
        if team.update(name: params[:team_name])
            flash[:notice] = "Successfully changed team name!"
            redirect "/teams/#{team.id}"
        else
            flash[:notice] = team.errors.full_messages.join
            redirect "/teams/#{team.id}/edit"
        end
    end

    delete '/teams' do
        league = League.find(params[:league_id])
        current_user.teams.detect {|team| team.league == league}.destroy
        flash[:notice] = "You have successfully quit the #{league.name.titleize} league!"
        redirect "/users/#{current_user.id}"
    end
end
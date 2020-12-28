class PlayerController < ApplicationController
    
    get '/players/new' do
        @teams = current_user.teams
        erb :'players/new'
    end

    post '/players' do
        team = Team.find(params[:team_id]) if params[:team_id] != nil
        redirect '/players/new' if params[:name] == '' || params[:position] == nil || !team || team.league.players.detect {|player| player.name == params[:name]}
        player = Player.new(name: params[:name], position: params[:position])
        player.team = team
        player.save
        redirect "/users/#{current_user.id}"
    end
end
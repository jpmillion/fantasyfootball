class PlayerController < ApplicationController

    before '/players/*' do
        login_required
    end
    
    get '/players/new' do
        @teams = current_user.teams
        erb :'players/new'
    end

    post '/players' do
        team = Team.find(params[:team_id]) if params[:team_id] != nil
        redirect "/teams/#{team.id}" if params[:name] == '' || params[:position] == nil || team.league.players.any? {|player| player.name == params[:name]}
        player = Player.new(name: params[:name], position: params[:position])
        team.players << player
        redirect "/teams/#{team.id}"
    end

    delete '/players' do
        binding.pry 
        Player.delete(params[:player_id])
        redirect "/teams/#{params[:team_id]}"
    end
end
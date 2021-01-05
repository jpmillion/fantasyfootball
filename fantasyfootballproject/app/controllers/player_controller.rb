class PlayerController < ApplicationController

    post '/players' do
        team = Team.find(params[:team_id]) if params[:team_id] != nil
        redirect "/teams/#{team.id}" if params[:name] == '' || params[:position] == nil || team.league.players.any? {|player| player.name == params[:name]}
        
        team.players << Player.new(name: params[:name], position: params[:position])
        redirect "/teams/#{team.id}"
    end

    delete '/players' do 
        Player.delete(params[:player_id])
        redirect "/teams/#{params[:team_id]}"
    end
end
class PlayerController < ApplicationController

    post '/players' do
        team = Team.find(params[:team_id]) if params[:team_id] != nil
        flash[:notice] = "**Player was not added to roster, please try again"
        redirect "/teams/#{team.id}" if params[:name] == '' || params[:position] == nil || team.league.players.any? {|player| player.name == params[:name]}
        
        team.players << Player.new(name: params[:name], position: params[:position])
        flash[:notice] = "#{params[:name].titleize} successfully added to roster!"
        redirect "/teams/#{team.id}"
    end

    delete '/players' do
        player = Player.find(params[:player_id]) 
        flash[:notice] = "#{player.name.titleize} was successfully deleted from roster!"
        player.destroy
        redirect "/teams/#{params[:team_id]}"
    end
end
class TeamsController < ApplicationController
  load_and_authorize_resource find_by: :hash_id, except: [:create]

  def index
    @teams = visible_teams
  end

  def show
    @team = Team.friendly.includes(:users).find(params[:id])
  end

  def new
    @team = Team.new
  end

  def create

  end

  def destroy
    @team = Team.friendly.find(params[:id])
    @team.destroy
    redirect_to teams_url, notice: 'team was successfully destroyed.'
  end
end
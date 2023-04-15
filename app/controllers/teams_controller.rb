# Endpoints to: Create/Update/Delete/Index/Show teams
# Endpoint to: Get the members of a specific team
class TeamsController < ApplicationController
  before_action :set_team, only: %i[show edit update destroy]

  def index
    @teams = Team.all
  end

  def show; end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)

    if @team.save
      redirect_to @team, notice: 'Team was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @team.update(team_params)
      redirect_to @team, notice: 'Team was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @team.members.any?
      redirect_to @team, alert: 'You cannot delete a team with members'
    else
      @team.destroy
      redirect_to teams_url, notice: 'Team was successfully destroyed.'
    end
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name)
  end
end

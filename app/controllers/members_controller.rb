# Endpoints to: Create/Update/Delete/Index/Show members
# Endpoint to: Update the team of a member
# Endpoint to: Add a member to a project
class MembersController < ApplicationController
  before_action :set_member, only: %i[show edit update destroy add_project projects]

  def index
    @members = Member.all
  end

  def show; end

  def new
    @member = Member.new
  end

  def create
    @member = Member.new(member_params)

    if @member.save
      redirect_to @member, notice: 'Member was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @member.update(member_params)
      redirect_to @member, notice: 'Member was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @member.destroy
    redirect_to members_url, notice: 'Member was successfully destroyed.'
  end

  def add_project
    project = Project.find(params[:project_id])
    @member.projects << project
    redirect_to member_path(@member), notice: 'Member was successfully added to the project.'
  end

  private

  def set_member
    @member = Member.find(params[:id])
  end

  def member_params
    params.require(:member).permit(:first_name, :last_name, :city, :state, :country, :team_id)
  end
end



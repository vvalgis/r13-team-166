class ProjectController < ApplicationController
  def index
    @projects = Project.all #if user_signed_in?
  end
end

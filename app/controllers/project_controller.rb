class ProjectController < ApplicationController
  def index
    @projects = Project.all #:conditions => { :owner_id => current_user.id }
  end
end

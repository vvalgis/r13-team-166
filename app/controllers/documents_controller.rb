class DocumentsController < ApplicationController
  before_action :set_project
  before_action :authenticate_user!

  def new
    @document = @project.documents.build
  end

  def create
    @document = @project.documents.build(document_params)

    if @document.save
      redirect_to @project, notice: 'Project was successfully created.'
    else
      render action: 'new'
    end
  end

  private 

  def set_project
    @project = Project.find(params[:project_id])
  end

  def document_params
    params.require(:document).permit(:comment, :lang)
  end
end

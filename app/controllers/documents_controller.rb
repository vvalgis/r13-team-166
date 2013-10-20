class DocumentsController < ApplicationController
  before_action :set_project
  before_action :authenticate_user!

  def new
    @document = @project.documents.build(parent_id: params[:parent_id])
  end

  def create
    @original = @project.documents.find(params[:document][:parent_id])
    @document = @project.documents.build(document_params)
    @document.text = @original.text.to_s

    if @document.save
      redirect_to @project, notice: 'Project was successfully created.'
    else
      render action: 'new'
    end
  end

  def show
    @document = @project.documents.find(params[:id])
  end

  def edit
    @document = @project.documents.find(params[:id])
    render layout: 'document_edit'
  end

  def translate
    @document = @project.documents.find(params[:id])
    @original = @document.original
    render layout: 'document_edit'
  end

  private 

  def set_project
    @project = current_user.projects.find(params[:project_id])
  end

  def document_params
    params.require(:document).permit(:comment, :lang, :text, :parent_id)
  end
end

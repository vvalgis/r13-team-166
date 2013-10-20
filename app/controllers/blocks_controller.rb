class BlocksController < ApplicationController
  before_action :set_project
  before_action :set_document
  before_action :authenticate_user!

  def update
    @document.text.update_block(params[:id], params[:block_text])
    @document.text.save
    redirect_to translate_project_document_path(@project, @document)
  end

  private

  def set_project
    @project = current_user.projects.find(params[:project_id])
  end

  def set_document
    @document = @project.documents.find(params[:document_id])
  end

  # def block_params
  #   params.require(:block).permit(:text)
  # end
end
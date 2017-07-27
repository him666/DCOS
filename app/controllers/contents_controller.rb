class ContentsController < ApplicationController
  before_action :authenticate_user!
  def interactions
  @content = Content.find(params[:id])
  end
  private
  def set_content
    @content = Content.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def content_params
    params.require(:content).permit(:oftype,:msg,:by_who,:author, :content_id, :id)
  end
end
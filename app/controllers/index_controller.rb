class IndexController < ApplicationController
  before_action :authenticate_user!

  def document

    @doc = Document.first
    @h_params = [] if @h_params.nil?
    @sections = Chapter.first.sections

    unless params[:chapter_id].nil?
      @sections = Chapter.find(params[:chapter_id]).sections
      @h_params[0]=params[:chapter_id]
    end

    @subsections = Section.first.subsections

    unless params[:section_id].nil?
      @subsections = Section.find(params[:section_id]).subsections
      @h_params[1]=params[:section_id]
    end

    @contents = Subsection.first.contents

    unless params[:subsection_id].nil?
    @contents = Subsection.find(params[:subsection_id]).contents
    @h_params[2]=params[:subsection_id]
    end
    pp @h_params
  end

  def home
    privilege_granter(current_user)
  end

  def admin
    redirect_to index_home_path unless has_privilege(current_user)
    @users = User.all.sort_by { |user| user.email }
  end

  def permission
    u = User.find(params[:user_id])
    promotion(u, params[:permission], params[:name])
    redirect_to index_admin_path
  end

  private

  def privilege_granter(user, privilege = 'commoner', name = 'normal')
    if user.privileges.first.nil?
      p = Privilege.new
      p.name = name
      p.level = privilege
      user.privileges << p
      p.save
    end
  end

  def promotion(user, privilege = 'root', name = 'admin')
    p = Privilege.new
    p = user.privileges.first unless user.privileges.first.nil?
    p.user_id = user.id
    p.name = name
    p.level = privilege
    p.save
  end

  def document_params
    params.require(@params).permit(:chapter_id, :section_id, :subsection_id)
  end

  def has_privilege(current_user)
    current_user.privileges.first.level == 'root' ? true : false
  end
end

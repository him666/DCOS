class IndexController < ApplicationController
  before_action :authenticate_user!
  def document

  @doc = Document.first

  @sections = Chapter.first.sections
  @sections = Chapter.find(params[:chapter_id]).sections unless params[:chapter_id].nil?


  @subsections = Section.first.subsections
  @subsections = Section.find(params[:section_id]).subsections unless params[:section_id].nil?

  @contents = Subsection.first.contents
  @contents = Subsection.find(params[:subsection_id]).contents unless params[:subsection_id].nil?
  end

  def home
    privilege_granter(current_user)
  end

  def admin
    redirect_to index_home_path unless has_privilege(current_user)
    @users = User.all.sort_by {|user| user.email}
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

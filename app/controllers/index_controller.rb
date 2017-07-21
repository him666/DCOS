class IndexController < ApplicationController
  before_action :authenticate_user!

  def home
    privilege_granter(current_user)
  end

  private

  def privilege_granter(user, privilege = 'commoner')
    if user.privileges.first.nil?
      p = Privilege.new
      p.name = 'normal'
      p.level = privilege
      user.privileges << p
      p.save
    end
  end
end

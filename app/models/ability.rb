#-----------------------------------------------------
# Author  : Upender Devulapally
# Updated : 21-06-2011 00:30
#------------------------------------------------------

class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new # Guest user
    if user.role.name.eql?('Super Admin')
      #can manage all operation(actions) on all Models in Application
      can :manage ,:all
    else
      user.role.permissions.each do |permission|
        if user.role.id == permission.authorization.role_id         
          #can manage(all actions)for a given Model if boolean flag manage_all is true irrespective of other permissions(from permissions table)
          #------------------------------------------------------------------------------------------------------
          (can :manage ,permission.authorization.name.camelize.constantize) if permission.authorization.manage_all?
          #-------------------------------------------------------------------------------------------------------
          can permission.name.to_sym,permission.authorization.name.camelize.constantize # "user".camelize#=>"User";"User".constantize#=>User
          ### To read all actions for a Model
          (can :read, permission.authorization.name.camelize.constantize) if permission.name == 'read'
        end
      end
    end
    #can read(not prmitted to create or update) all operation(actions) on all Models in Application
    
  end
end

=begin
class Ability
include CanCan::Ability
def initialize(user)
can :read, :all                   # allow everyone to read everything
if user && user.admin?
can :access, :rails_admin       # only allow admin users to access Rails Admin
if user.role? :superadmin
can :manage, :all             # allow superadmins to do anything
elsif user.role? :manager
can :manage, [User, Product]  # allow managers to do anything to products and users
elsif user.role? :sales
can :update, Product, :hidden => false  # allow sales to only update visible products
end
end
end
end
=end
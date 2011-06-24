class SuperAdmin::RolesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :recent,:only=>[:index]
  load_and_authorize_resource
  def index
    @roles = Role.search(params[:search])
    @role = Role.new
  end

  def show
    @role = Role.find(params[:id])
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new(params[:role])
    if @role.save
      redirect_to [:super_admin, @role], :notice => "Successfully created Role."
    else
      render :action => 'new'
    end
  end

  def edit
    @role = Role.find(params[:id])
  end

  def update
    @role = Role.find(params[:id])
    if @role.update_attributes(params[:role])
      redirect_to [:super_admin, @role], :notice  => "Successfully updated Role."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @role = Role.find(params[:id])
    #@role.destroy
    redirect_to super_admin_roles_url, :notice => "Successfully destroyed Role."
  end

  def permissions
    @role = Role.find(params[:id])
    @abilities = {'User'=>['create','update'],'Topic'=>['create','update']}
=begin
    if @role.authorizations.blank? # already permissions exists don't build childrens
      #define Models and their actions in Hash of Arrays
     
      @abilities.each do |key,values|
        @role.authorizations_attributes = [{:name=>key}] #construct form attributes for authorizations(using nested attributes)
      end
      #construct form attributes for permissions on above created authorizations
      @role.authorizations.each do |authorization|
      #to build autharization.permissions_attributes = [{:name=>'create'},{:name=>'update'}],
      #get the array of values from abilities Hash with key already assigned to authorization
        authorization.permissions_attributes =  @abilities[authorization.name].collect!{|val| {:name=>val} }
      end
    end
=end  
  end

  def assign_permissions
    @abilities = {'User'=>['create','update'],'Topic'=>['create','update']}
    @role = Role.find(params[:id])
    ## delete all authorizations and create again same for permissions
    @role.authorizations.clear
    if @role.update_attributes(params[:role])
      flash[:notice] = "Group Permissions Assigned Successfully.."
      redirect_to super_admin_roles_path
    else
      #flash.now[:error] = "ERROR"
      render 'permissions'
    end
  end
  private

  def recent
    @recent = Role.recent
  end
end

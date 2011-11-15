require 'csv'
class SuperAdmin::UsersController < ApplicationController
  before_filter :authenticate_user! #, #:recent#, :except => [:show, :index]
                                    #before_filter :accessible_roles, :only => [:new, :edit, :show, :update, :create]
                                    #load_and_authorize_resource #:only => [:show,:new,:destroy,:edit,:update]
                                    #    layout "application", :except => [:show, :edit]
  layout "application", :except => [:show, :edit]

  def index
    #@users = 
    @users = User.search(params[:search], current_user, params[:id]).paginate(:page =>params[:page], :per_page=>20).order("created_at DESC")
    @user = User.new(:role_id=>params[:id])
  end

  def new
    respond_to do |format|
      format.json { render :json => @user }
      format.xml { render :xml => @user }
      format.html
    end
  end

  def show
    @user = User.find(params[:id])
=begin
    respond_to do |format|
      format.json { render :json => @user }
      format.xml  { render :xml => @user }
      format.html
    end

  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:json, :xml, :html)
=end
  end

  def edit
    @user = User.find(params[:id])
=begin
    respond_to do |format|
      format.json { render :json => @user }
      format.xml  { render :xml => @user }
      format.html
    end

  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:json, :xml, :html)
=end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to super_admin_users_path, :notice => "User deleted Successfully."
=begin
    @user.destroy!

    respond_to do |format|
      format.json { respond_to_destroy(:ajax) }
      format.xml  { head :ok }
      format.html { respond_to_destroy(:html) }
    end

  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:json, :xml, :html)
=end
  end

  def create
    @user = User.new(params[:user])
    if (params[:user][:role_id].to_i == 4)
      @user.enrollment_no = params[:user][:password]
    else
      @user.enrollment_no= '---'
    end

    if @user.save
      flash[:notice] = "User Created Successfully."
      respond_to do |format|
        format.json { render :json => @user.to_json, :status => 200 }
        format.xml { head :ok }
        if has_role?(:service_provider)
          @follow = Following.new(:user_id=>@user.id, :follower_id=>params[:user][:provider_id])
          @follow.save
          format.html { redirect_to :controller => service_provider_students_path }
        else
          format.html { redirect_to :action => :index }

        end
      end
    else
      respond_to do |format|
        format.json { render :text => "Could not create user", :status => :unprocessable_entity } # placeholder
        format.xml { head :ok }
        format.html { render :action => :new, :status => :unprocessable_entity }
      end
    end
  end


  def approve
    @user = User.find(params[:id])
    @user.update_attribute('approved', @user.approved? ? false : true)
    respond_to do |format|
      format.js
    end
  end

  def update
    if params[:user][:password].blank?
      [:password, :password_confirmation, :current_password].collect { |p| params[:user].delete(p) }
    else
      @user.errors[:base] << "The password you entered is incorrect" unless @user.valid_password?(params[:user][:current_password])
    end

    respond_to do |format|
      if @user.errors[:base].empty? and @user.update_attributes(params[:user])
        flash[:notice] = "User Details updated Successfully"
        format.json { render :json => @user.to_json, :status => 200 }
        format.xml { head :ok }
        format.html { render :action => :edit }
      else
        format.json { render :text => "Could not update user", :status => :unprocessable_entity } #placeholder
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
        format.html { render :action => :edit, :status => :unprocessable_entity }
      end
    end

  rescue ActiveRecord::RecordNotFound
    respond_to_not_found(:js, :xml, :html)
  end

  def profile
    @user = User.find(params[:id])
  end

  def csv_import
    csv_file = params[:file]
    n=0
    if has_role?(:super_admin)
      CSV.new(csv_file.tempfile, :col_sep => ",").each do |row|
        @user = User.create do |u|
          u.name =row[0]
          u.last_name = row[1]
          u.email = row[2]
          u.secondary_number = row[4]
          u.primary_number = row[3]
          u.approved = '1'
          role = Role.find_by_name(row[5].strip)
          ran_num = rand(1000000000-9999999999)
          u.password = u.password_confirmation = ran_num
          if role.name == "Student"
            u.enrollment_no = ran_num
          else
            u.enrollment_no= '---'
          end
          u.role_id=role.id
        end
        @user.save
        n=n+1
      end
    elsif has_role?(:service_provider)
      CSV.new(csv_file.tempfile, :col_sep => ",").each do |row|
        @user = User.create do |u|
          u.name =row[0]
          u.last_name = row[1]
          u.email = row[2]
          u.secondary_number = row[4]
          u.primary_number = row[3]
          u.approved = '1'
          ran_num = rand(1000000000-9999999999)
          u.password = u.password_confirmation = ran_num
          u.enrollment_no = ran_num
          u.role_id=params[:role_id]
        end
        @user.save
        @follow = Following.new(:user_id=>@user.id, :follower_id=>params[:provider_id])
        @follow.save

        n=n+1
      end
    end

    flash[:notice]= "#{n} Users are imported Successfully"
    respond_to do |format|
      if has_role?(:service_provider) and params[:role_id] == 4
        format.html { redirect_to :controller => service_provider_students_path }
      elsif
      format.html { redirect_to :controller => service_provider_assessors_path }
                                                                                    else
        format.html { redirect_to :action => :index }
        format.xml { head :ok }
      end
    end
  end

  def upload
  end

  def export
    require 'fastercsv'
    users = User.order("created_at")
    outfile = "Users -" + Time.now.strftime("%d-%m-%Y-%H-%M-%S") + ".csv"
    csv_data = FasterCSV.generate do |csv|
      csv << ["First Name", "Last Name", "Enrollment #", "Email", "Primary Contact", "Status", "Created At"]
      users.each do |u|
        csv << [u.name, u.last_name, u.enrollment_no, u.email, u.primary_number, u.approved? ? 'Yes' : 'No', u.created_at.strftime('%m.%b.%y')]
      end
    end
    send_data csv_data,
              :type => 'text/csv; charset=iso-8859-1; header=present',
              :disposition => "attachment; filename=#{outfile}"
  end

  def reset
    @user = User.find(params[:id])
    @user.password= @user.password_confirmation=@user.enrollment_no
    respond_to do |format|
      if @user.update_attributes(params[:user])
        ExamNotifier.reset_password(@user)
        format.html { redirect_to(super_admin_users_path, :notice => 'User Password is  successfully Reset.') }
        format.xml { head :ok }
      else
      end
    end
  end

end


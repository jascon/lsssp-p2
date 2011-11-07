class CouponsController < ApplicationController
  before_filter :authenticate_user!
#  load_and_authorize_resource
  before_filter :recent, :only=>[:index]
  layout "application", :except => [:show, :edit]

  def index
    if has_role?(:super_admin)
    @coupons = Coupon.search(params[:search]).paginate(:page =>params[:page], :per_page=>20)
    @coupon = Coupon.new
    else
    @coupons = Coupon.where(:provider_id => current_user.id).search(params[:search]).paginate(:page =>params[:page], :per_page=>20)
    end
  end

  def show
    @coupon = Coupon.find(params[:id])
  end

  def new
    @coupon = Coupon.new
  end

  def edit
    @coupon = Coupon.find(params[:id])
  end

  def create
=begin
    @coupon = Coupon.new(params[:coupon])

    respond_to do |format|
      if @coupon.save
        format.html { redirect_to(coupons_url, :notice => 'Coupon was successfully created.') }
        format.xml  { render :xml => @coupon, :status => :created, :location => @coupon }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @coupon.errors, :status => :unprocessable_entity }
      end
    end

=end
    i = 1
    while (i <= params[:length].to_i)
      coupon = (0..9).map { rand(36).to_s(36) }.join
      @coupon = Coupon.new(:coupon=>coupon, :provider_id=>params[:user_id],:created_by=>current_user.id,:created_date=>Date.today)
      @coupon.save
      i = i +1
    end
    flash[:notice]= "#{i -1} Coupons Generated Successfully"
    respond_to do |format|
      format.html { redirect_to :action => :index }
      format.xml { head :ok }
    end
  end

  def update
    @coupon = Coupon.find(params[:id])

    respond_to do |format|
      if @coupon.update_attributes(params[:coupon])
        format.html { redirect_to(coupons_url, :notice => 'Coupon was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @coupon.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @coupon = Coupon.find(params[:id])
    @coupon.destroy

    respond_to do |format|
      format.html { redirect_to(coupons_url) }
      format.xml { head :ok }
    end
  end

private

  def recent
    @recent = Coupon.recent
  end
end

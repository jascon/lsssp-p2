class CreditsController < ApplicationController
  layout "application", :except => [:new, :history]

  def index
    @users = User.where(:role_id => 2).paginate(:page =>params[:page], :per_page=>20)
  end

  def show
    @credit = Credit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @credit }
    end
  end

  def new
    @credit = Credit.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @credit }
    end
  end

  def edit
    @credit = Credit.find(params[:id])
  end

  def create
    @credit = Credit.new(params[:credit])

    @user = User.find(params[:user_id])
    if params[:mode] == "credit"
      if Credit.where(:provider_id=>params[:user_id]).count== 0
        balance = params[:amount]
      else
        balance = Credit.where(:provider_id=>params[:user_id]).maximum("balance") + params[:amount].to_i
      end
      @credit = Credit.new(:provider_id=>params[:user_id], :credit=>params[:amount], :description=>params[:description], :balance=>balance, :amount=>params[:amount])
      @credit.save
    else
      if Credit.sum("debit") == 0
        balance = Credit.maximum("balance") - params[:amount].to_i
      else
        balance = Credit.where(:provider_id=>params[:user_id]).sum("credit") - Credit.where(:provider_id=>params[:user_id]).sum("debit") - params[:amount].to_i
      end
      @credit = Credit.new(:provider_id=>params[:user_id], :debit=>params[:amount], :description=>params[:description], :balance=>balance, :amount=>params[:amount])
      @credit.save
    end
    @user.credits = balance
    @user.save
    redirect_to(credits_url, :notice => "Credits Created Successfully")
  end

  def update
    @credit = Credit.find(params[:id])

    respond_to do |format|
      if @credit.update_attributes(params[:credit])
        format.html { redirect_to(@credit, :notice => 'Credit was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @credit.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @credit = Credit.find(params[:id])
    @credit.destroy

    respond_to do |format|
      format.html { redirect_to(credits_url) }
      format.xml { head :ok }
    end
  end

  def history
   @credits = Credit.where(:provider_id=>params[:id]).paginate(:page =>params[:page], :per_page=>20)
  end

end

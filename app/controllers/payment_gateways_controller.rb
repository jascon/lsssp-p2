class PaymentGatewaysController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  before_filter :recent,:only=>[:index]
  def index
    @payment_gateways = PaymentGateway.search(params[:search])
    @payment_gateway = PaymentGateway.new
  end

  def show
    @payment_gateway = PaymentGateway.find(params[:id])
  end

  def new
    @payment_gateway = PaymentGateway.new
  end

  def create
    @payment_gateway = PaymentGateway.new(params[:payment_gateway])
    if @payment_gateway.save
      #redirect_to @payment_gateway, :notice => "Successfully created payment gateway."
      redirect_to payment_gateways_path, :notice => "Successfully created payment gateway."
    else
      render :action => 'new'
    end
  end

  def edit
    @payment_gateway = PaymentGateway.find(params[:id])
  end

  def update
    @payment_gateway = PaymentGateway.find(params[:id])
    if @payment_gateway.update_attributes(params[:payment_gateway])
      redirect_to @payment_gateway, :notice  => "Successfully updated payment gateway."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @payment_gateway = PaymentGateway.find(params[:id])
    @payment_gateway.destroy
    redirect_to payment_gateways_url, :notice => "Successfully destroyed payment gateway."
  end
   def active
    super(PaymentGateway)
  end
  
   private

  def recent
    @recent = PaymentGateway.recent
  end
end

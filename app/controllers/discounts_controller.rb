class DiscountsController < ApplicationController
  before_action :find_merchant
  before_action :find_merchant_and_discount, only: [:show, :edit, :update, :destroy]

  def index
    @discounts = @merchant.discounts
    @holidays_service = HolidaysService.new
    @holidays = @holidays_service.holidays
  end

  def show
  end

  def new
    @discount = Discount.new
  end

  def create
    @discount = @merchant.discounts.new(discount_params)
  
    if @discount.save
      flash[:success] = "Discount created successfully!"
      redirect_to merchant_discounts_path(@merchant)
    else
      flash.now[:error] = "Failed to create the discount."
      render :new
    end
  end

  def edit
  end

  def update

      if @discount.update(discount_params)
        redirect_to merchant_discount_path(@merchant, @discount)
        flash[:success] = "Discount was successfully updated"
      else
        redirect_to edit_merchant_discount_path(@merchant, @discount)
        flash[:error] = "Please fill in all fields"
      end
  end

  def destroy
    @discount.destroy
    flash[:success] = "Discount deleted successfully!"
    redirect_to merchant_discounts_path(@merchant)
  end
  
  private
  
  def discount_params
    params.require(:discount).permit(:percentage_discount, :quantity_threshold)
  end

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def find_merchant_and_discount
    @discount = @merchant.discounts.find(params[:id])
  end
end
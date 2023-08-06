class DiscountsController < ApplicationController


  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.discounts
    @holidays_service = HolidaysService.new
    @holidays = @holidays_service.holidays
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = @merchant.discounts.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
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
    @merchant = Merchant.find(params[:merchant_id])
    @discount = @merchant.discounts.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @discount = @merchant.discounts.find(params[:id])

      if @discount.update(discount_params)
        redirect_to merchant_discount_path(@merchant, @discount)
        flash[:success] = "Discount was successfully updated"
      else
        redirect_to edit_merchant_discount_path(@merchant, @discount)
        flash[:error] = "Please fill in all fields"
      end
  end

  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    @discount = @merchant.discounts.find(params[:id])
    @discount.destroy

    flash[:success] = "Discount deleted successfully!"
    redirect_to merchant_discounts_path(@merchant)
  end
  
  private
  
  def discount_params
    params.require(:discount).permit(:percentage_discount, :quantity_threshold)
  end
end
require "rails_helper"

describe "merchant discounts show page" do
  before :each do
    @merchant1 = Merchant.create!(name: "Hair Care")
    @discount1 = Discount.create!(percentage_discount: 15, quantity_threshold: 10, merchant_id: @merchant1.id)
  end

  it "should show the discount
end
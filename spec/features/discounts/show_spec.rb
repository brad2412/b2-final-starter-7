require "rails_helper"

describe "merchant discounts show page" do
  before :each do
    @merchant1 = Merchant.create!(name: "Hair Care")
    @discount1 = Discount.create!(percentage_discount: 15, quantity_threshold: 10, merchant_id: @merchant1.id)
    @discount2 = Discount.create!(percentage_discount: 25, quantity_threshold: 15, merchant_id: @merchant1.id)
  end

  it "should show discount quantity threshold and percentage discount" do
    visit merchant_discount_path(@merchant1, @discount1)

    expect(page).to have_content("Discount: 1")

    expect(page).to have_content("Quantity Threshold: 10")
    expect(page).to have_content("Percentage Discount: 15")
    expect(page).to_not have_content("Quantity Threshold: 15")
    expect(page).to_not have_content("Percentage Discount: 25")
    
  end
end


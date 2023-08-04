require "rails_helper"

describe "merchant discount index" do
  before :each do
    @merchant1 = Merchant.create!(name: "Hair Care")

    @discount1 = Discount.create!(percentage_discount: 15, quantity_threshold: 10, merchant_id: @merchant1.id)
    @discount2 = Discount.create!(percentage_discount: 25, quantity_threshold: 15, merchant_id: @merchant1.id)
  end

    # US 1
  it "should show discounts and discount requirements" do
    visit merchant_discounts_path(@merchant1)

    expect(page).to have_content("Bulk Discounts")
    expect(page).to have_content("15% OFF: At least 10 of the same item is purchased.")
    expect(page).to have_content("25% OFF: At least 15 of the same item is purchased.")
    expect(page).to have_link("15% OFF")
    expect(page).to have_link("25% OFF")
    
    click_link("15% OFF")
    expect(current_path).to eq(merchant_discount_path(@merchant1, @discount1))
  end
end



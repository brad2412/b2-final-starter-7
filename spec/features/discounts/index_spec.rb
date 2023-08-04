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

    # US 2
  it "should have a link to create a new discount" do
    visit merchant_discounts_path(@merchant1)

    expect(page).to have_link("Create Discount")
    click_link("Create Discount")

    expect(current_path).to eq(new_merchant_discount_path(@merchant1))
  end

  # US 3
  # US 3
  it "should have a delete function next to each discount" do
    visit merchant_discounts_path(@merchant1)

    within "#discount_block-#{@discount1.id}" do
      expect(page).to have_button("Delete Discount")
      click_button("Delete Discount")
    end
    expect(page).to have_content("Discount deleted successfully!")
    expect(current_path).to eq(merchant_discounts_path(@merchant1))
    expect(page).not_to have_content("15% OFF: At least 10 of the same item is purchased.")
    expect(page).to have_content("25% OFF: At least 15 of the same item is purchased.")
    
  end
end

# 3: Merchant Bulk Discount Delete

# As a merchant
# When I visit my bulk discounts index
# Then next to each bulk discount I see a link to delete it
# When I click this link
# Then I am redirected back to the bulk discounts index page
# And I no longer see the discount listed





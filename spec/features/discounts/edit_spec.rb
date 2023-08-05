require "rails_helper"

RSpec.describe "merchant discounts edit page" do
  before :each do
    @merchant1 = Merchant.create!(name: "Hair Care")
    @discount1 = Discount.create!(percentage_discount: 15, quantity_threshold: 10, merchant_id: @merchant1.id)
  end

  # US 5
  it "should have a form with pre populated attributes for discount, once attributs are changed, takes you back to that discounts show page" do
    visit edit_merchant_discount_path(@merchant1, @discount1)
    # save_and_open_page
    expect(page).to have_content("Edit Discount: #{@discount1.id}")
    expect(page).to have_content("Quantity Threshold: 10")
    expect(page).to have_content("Percentage Discount: 15")

    expect(page).to have_field("Quantity threshold", with: "10")
    fill_in("Quantity threshold", with: "12")
    expect(page).to have_field("Percentage discount", with: "15")

    click_button "Submit"

    expect(current_path).to eq(merchant_discount_path(@merchant1, @discount1))
    expect(page).to have_content("Quantity Threshold: 12")
    expect(page).to_not have_content("Quantity Threshold: 10")
    end

    it "displays a flash message 'Please fill in all fields' when data entry is invalid" do
      visit edit_merchant_discount_path(@merchant1, @discount1)
  
      fill_in("Quantity threshold", with: "")
      fill_in("Percentage discount", with: "")
      click_button('Submit')
  
      expect(current_path).to eq(edit_merchant_discount_path(@merchant1, @discount1))
      expect(page).to have_text("Please fill in all fields")
    end
end






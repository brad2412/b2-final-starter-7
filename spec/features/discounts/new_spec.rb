require "rails_helper"

RSpec.describe "new discount page" do
  before :each do
    @merchant1 = Merchant.create!(name: "Hair Care")
  end
  it "should create a new discount" do
    visit new_merchant_discount_path(@merchant1)

    expect(page).to have_field("Percentage discount")
    fill_in("Percentage discount", with: 50)
    expect(page).to have_field("Quantity threshold")
    fill_in("Quantity threshold", with: 50)

    click_button("Create Discount")

    expect(current_path).to eq(merchant_discounts_path(@merchant1))

    expect(page).to have_content("50% OFF: At least 50 of the same item is purchased.")
    expect(page).to have_content("Discount created successfully!")
  end

  it "should return a failed message if no inputs are provided" do
    visit new_merchant_discount_path(@merchant1)

    expect(page).to have_field("Percentage discount")
    fill_in("Percentage discount", with: 50)
    expect(page).to have_field("Quantity threshold")
    fill_in("Quantity threshold", with: "")

    click_button("Create Discount")

    expect(page).to have_content("Failed to create the discount.")
  end
end



# 2: Merchant Bulk Discount Create

# As a merchant
# When I visit my bulk discounts index
# Then I see a link to create a new discount
# When I click this link
# Then I am taken to a new page where I see a form to add a new bulk discount
# When I fill in the form with valid data
# Then I am redirected back to the bulk discount index
# And I see my new bulk discount listed

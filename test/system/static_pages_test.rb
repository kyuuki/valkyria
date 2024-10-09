require "application_system_test_case"

class StaticPagesTest < ApplicationSystemTestCase
  test "visiting root" do
    @site = FactoryBot.create(:site)

    visit root_url

    assert_selector "h1", text: "SAILOR"
  end
end

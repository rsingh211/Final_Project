require "application_system_test_case"

class BeatsTest < ApplicationSystemTestCase
  setup do
    @beat = beats(:one)
  end

  test "visiting the index" do
    visit beats_url
    assert_selector "h1", text: "Beats"
  end

  test "should create beat" do
    visit beats_url
    click_on "New beat"

    fill_in "Description", with: @beat.description
    fill_in "Genre", with: @beat.genre
    fill_in "License type", with: @beat.license_type
    fill_in "Price", with: @beat.price
    fill_in "Title", with: @beat.title
    click_on "Create Beat"

    assert_text "Beat was successfully created"
    click_on "Back"
  end

  test "should update Beat" do
    visit beat_url(@beat)
    click_on "Edit this beat", match: :first

    fill_in "Description", with: @beat.description
    fill_in "Genre", with: @beat.genre
    fill_in "License type", with: @beat.license_type
    fill_in "Price", with: @beat.price
    fill_in "Title", with: @beat.title
    click_on "Update Beat"

    assert_text "Beat was successfully updated"
    click_on "Back"
  end

  test "should destroy Beat" do
    visit beat_url(@beat)
    click_on "Destroy this beat", match: :first

    assert_text "Beat was successfully destroyed"
  end
end

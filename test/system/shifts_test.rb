require "application_system_test_case"

class ShiftsTest < ApplicationSystemTestCase
  setup do
    @shift = shifts(:one)
  end

  test "visiting the index" do
    visit shifts_url
    assert_selector "h1", text: "Shifts"
  end

  test "creating a Shift" do
    visit shifts_url
    click_on "New Shift"

    fill_in "User", with: @shift.user_id
    fill_in "Working day", with: @shift.working_day
    fill_in "Working status", with: @shift.working_status_id
    fill_in "Working time", with: @shift.working_time
    click_on "Create Shift"

    assert_text "Shift was successfully created"
    click_on "Back"
  end

  test "updating a Shift" do
    visit shifts_url
    click_on "Edit", match: :first

    fill_in "User", with: @shift.user_id
    fill_in "Working day", with: @shift.working_day
    fill_in "Working status", with: @shift.working_status_id
    fill_in "Working time", with: @shift.working_time
    click_on "Update Shift"

    assert_text "Shift was successfully updated"
    click_on "Back"
  end

  test "destroying a Shift" do
    visit shifts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Shift was successfully destroyed"
  end
end

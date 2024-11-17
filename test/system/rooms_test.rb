require "application_system_test_case"

class RoomsTest < ApplicationSystemTestCase
  setup do
    @room = rooms(:one)
  end

  test "visiting the index" do
    visit rooms_url
    assert_selector "h1", text: "Rooms"
  end

  test "should create room" do
    visit root_url 
    click_on "Démarrer une session"

    fill_in "room_name", with: @room.name
    fill_in "room_moderator_name" , with: "Moderator" 
    fill_in "room_team_name", with: "Agilab"
    click_on "Créer"

    assert_text "Room was successfully created"
    click_on "Back"
  end

  test "should update Room" do
    visit room_url(@room)
    click_on "Edit this room", match: :first

    fill_in "Name", with: @room.name
    fill_in "Shared link", with: @room.shared_link
    fill_in "Status", with: @room.status
    fill_in "Uuid", with: @room.uuid
    click_on "Update Room"

    assert_text "Room was successfully updated"
    click_on "Back"
  end

  test "should destroy Room" do
    visit room_url(@room)
    click_on "Destroy this room", match: :first
    assert_text "Room was successfully destroyed"
  end
end

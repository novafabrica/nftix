require 'spec_helper'

def fill_in_note(string="some note text")
  fill_the_following({
        "note_text" => string
    })
end

# fetches all tr in #notes with id like 'note-1'
def note_id_rows
  page.all('#notes tr[id*="note-"]')
end

def login_to_staff
  @admin = FactoryGirl.create(:admin, :username => "adminuser", :password => "adminpassword", :password_confirmation => "adminpassword")
  visit "/staff"
  fill_the_following({
      "Username" => 'adminuser',
      "Password" => 'adminpassword'
  })
  click_button('Log in')
  page.should have_content("Main Menu")
end
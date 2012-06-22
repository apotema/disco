require "spec_helper"

describe "music administration", js: true do

  describe "when creating a new music" do
    
    let!(:album) {FactoryGirl.create :album }

    before { visit new_album_music_path(album) }

    it "should save succesfully given a valid music" do
      fill_in 'Name', with: "GREAT MUSIC"
      click_on_save
      page.should have_content "GREAT MUSIC"
    end

    it "should show errors given an invalid music" do
      click_on_save
      page.should have_css ".alert.alert-error"
    end

  end

  context "given some musics" do
    let!(:album) {FactoryGirl.create :album }
    let!(:musics) { FactoryGirl.create_list(:music, 10, album: album) }
    let!(:music) { musics.last }

    before { visit album_path(album) }

    describe "when listing musics" do
      it "should display all given musics" do
        for music in musics do
          page.should have_content(music.name)
        end
      end
    end

    describe "when editing a music" do
      it "should save succesfully given a valid music" do
        click_action_link_for_music 'Edit', music
        fill_in 'Name', with: "MUSIC"
        click_on_update
        page.should have_no_content music.name
        page.should have_content "MUSIC"
      end

      it "should show errors given an invalid music" do
        click_action_link_for_music 'Edit', music
        fill_in 'Name', with: ""
        click_on_update
        page.should have_css ".alert.alert-error"
      end
    end

    describe "when destroying a music" do
      it "should destroy the chosen music" do
        click_action_link_for_music 'Destroy', music
        page.driver.browser.switch_to.alert.accept
        page.should have_no_content music.name
      end
    end
  end

  def click_on_save
    click_on 'Create Music'
  end

  def click_on_update
    click_on 'Update Music'
  end

  def click_action_link_for_music action, music
    page.find(:xpath, "//table/tbody/tr[td[contains(.,'#{music.name}')]]/td/a[contains(., '#{action}')]").click
  end

end
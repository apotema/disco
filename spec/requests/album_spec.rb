require "spec_helper"

describe "album administration", js: true do

  describe "when creating a new album" do
    
    before { visit new_album_path }

    it "should save succesfully given a valid album" do
      fill_in 'Name', with: "ONE"
      fill_in 'Year', with: 1990
      attach_file "Cover", "#{Rails.root}/spec/fixtures/rails.jpg"
      click_on_save
      page.should have_content "ONE"
      page.should have_content "1990"
      page.should have_xpath("//img[contains(@src,'rails.jpg')]")
    end

    it "should show errors given an invalid album" do
      click_on_save
      page.should have_css ".alert.alert-error"
    end

  end

  context "given some albums" do
    
    let!(:albums) { FactoryGirl.create_list(:album, 10) }
    let!(:album) { albums.last }
    before { visit albums_path }

    describe "when listing albums" do
      it "should display all given albums" do
        for album in albums do
          page.should have_content(album.name)
        end
      end
    end

    describe "when editing a album" do
      it "should save succesfully given a valid album" do
        click_action_link_for_album 'Edit', album
        fill_in 'Name', with: "TWO"
        click_on_update
        page.should have_no_content album.name
        page.should have_content "TWO"
      end

      it "should show errors given an invalid album" do
        click_action_link_for_album 'Edit', album
        fill_in 'Name', with: ""
        click_on_update
        page.should have_css ".alert.alert-error"
      end
    end

    describe "when destroying a album" do
      it "should destroy the chosen album" do
        click_action_link_for_album 'Destroy', album
        page.driver.browser.switch_to.alert.accept
        page.should have_no_content album.name
      end
    end
  end

  def click_on_save
    click_on 'Create Album'
  end

  def click_on_update
    click_on 'Update Album'
  end

  def click_action_link_for_album action, album
    page.find(:xpath, "//table/tbody/tr[td[contains(.,'#{album.name}')]]/td/a[contains(., '#{action}')]").click
  end

end
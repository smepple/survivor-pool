require 'spec_helper'

describe "User pages" do

  describe "Profile page" do
  end

  describe "Edit profile page" do

    before do
      @user = User.create! do |u|
                    u.name = 'Foo Bar'
                    u.username = 'foobar'
                    u.email = 'foobar@example.com'
                    u.password = 'foobarbaz'
                  end
      sign_in @user
      visit edit_user_registration_path(@user)
    end

    it "should display the date of last sign in" do
      page.should have_content @user.last_sign_in_at
    end

    it "should display the required fields" do
      page.should have_selector 'input', label: 'Avatar'
      page.should have_selector 'input', label: 'Name'
      page.should have_selector 'input', label: 'Username'
      page.should have_selector 'input', label: 'Email'
      page.should have_button 'Update'
      page.should have_link 'Cancel'
    end

    it "should display link for resetting password" do
      page.should have_link 'Forgot your password?'
    end

    it "should display link for cancelling account" do
      page.should have_link 'Cancel my account'
    end

    describe "successfully editing profile" do
      let(:new_name) { 'Baz Blurg' }
      let(:new_username) { 'bazblurg' }
      let(:new_email) { 'bazblurg@example.com' }

      before do
        fill_in 'Name', with: new_name
        fill_in 'Username', with: new_username
        fill_in 'Email', with: new_email
        click_button 'Update'
      end

      it "should update the user's attributes" do
        @user.reload.name.should == new_name
        @user.reload.username.should == new_username
        @user.reload.email.should == new_email
      end

      it "should display a success message" do
        page.should have_content 'profile was updated'
      end
    end

    describe "editing profile with invalid info" do
      before do
        fill_in 'Name', with: ''
        fill_in 'Username', with: ''
        fill_in 'Email', with: ''
        click_button 'Update'
      end

      it "should not change user attributes" do
        @user.reload.name.should == 'Foo Bar'
        @user.reload.username.should == 'foobar'
        @user.reload.email.should == 'foobar@example.com'
      end

      it "should display errors" do
        page.should have_content "can't be blank"
      end
    end
  end
end

require 'spec_helper'

describe "StaticPages" do
  
  describe "Home page" do

    before { visit root_path }

    it "should display the app name" do
      page.should have_content 'Survivor Pool'
    end

    it "should have a button for signing in with Facebook" do
      page.should have_link 'Sign in with Facebook'
    end

    it "should have links for creating an account and signing in" do
      page.should have_link 'Create an account'
      page.should have_link 'Sign in'
    end
  end

  describe "Signup page" do

    before do
      visit root_path
      click_link 'Create an account'
    end

    it "should display all required fields" do
      page.should have_selector 'input', label: 'Name'
      page.should have_selector 'input', label: 'Username'
      page.should have_selector 'input', label: 'Email'
      page.should have_selector 'input', label: 'Password'
      page.should have_selector 'input', label: 'Password confirmation'
      page.should have_button 'Sign up'
      page.should have_link 'Cancel'
      page.should have_link 'Home'
    end

    describe "successfully signing up" do

      describe "as a non-Facebook user" do

        before do
          fill_in 'Name', with: 'Foo Bar'
          fill_in 'Username', with: 'foobar'
          fill_in 'Email', with: 'foobar@example.com'
          fill_in 'Password', with: 'foobarbaz'
          fill_in 'Password confirmation', with: 'foobarbaz'
        end

        it "should create a new user" do
          expect { click_button 'Sign up' }.to change(User, :count).by(1)
        end
      end
    end

    describe "failed signup" do

      describe "as a non-Facebook user" do

        describe "when missing required fields" do

          before do
            fill_in 'Name', with: ''
            fill_in 'Username', with: ''
            fill_in 'Email', with: ''
            fill_in 'Password', with: ''
            fill_in 'Password confirmation', with: ''
          end

          it "should not create a new user" do
            expect { click_button 'Sign up' }.not_to change(User, :count)
          end

          it "should display error messages" do
            page.should have_content "can't be blank"
          end
        end
      end
    end
  end

  describe "Signin page" do

    before do
      visit root_path
      click_link 'Sign in'
    end

    it "should display all required fields" do
      page.should have_selector 'input', label: 'Login'
      page.should have_selector 'input', label: 'Password'
      page.should have_button 'Sign in'
      page.should have_link 'Cancel'
      page.should have_link 'Home'
    end

    describe "successfully signing in" do

      describe "as a non-Facebook user" do

        before do
          @user = User.create! do |u|
                    u.name = 'Foo Bar'
                    u.username = 'foobar'
                    u.email = 'foobar@example'
                    u.password = 'foobarbaz'
                  end
        end

        describe "using username as login" do
          before do
            fill_in 'Login', with: @user.username
            fill_in 'Password', with: 'foobarbaz'
            click_button 'Sign in'
          end

          it "should sign the user in" do
            page.should have_content "Hello, #{@user.username}"
          end
        end

        describe "using email as login" do
          before do
            fill_in 'Login', with: @user.email
            fill_in 'Password', with: 'foobarbaz'
            click_button 'Sign in'
          end

          it "should sign the user in" do
            page.should have_content "Hello, #{@user.username}"
          end
        end
      end
    end

    describe "failed signin" do

      describe "as a non-Facebook user" do

        before do
          @user = User.create! do |u|
                    u.name = 'Foo Bar'
                    u.username = 'foobar'
                    u.email = 'foobar@example'
                    u.password = 'foobarbaz'
                  end
        end

        describe "with incorrect login and password" do

          before do
            fill_in 'Login', with: ''
            fill_in 'Password', with: 'foobarbaz'
            click_button 'Sign in'
          end

          it "should not sign the user in" do
            page.should_not have_content "Hello, #{@user.username}"
          end

          it "should display error messages" do
            page.should have_selector 'div.alert', text: 'Invalid login or password'
          end
        end
      end
    end
  end
end

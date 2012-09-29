def sign_in(user)
  visit root_path
  click_link 'Sign in'
  fill_in 'Login', with: user.username
  fill_in 'Password', with: user.password
  click_button 'Sign in'
end
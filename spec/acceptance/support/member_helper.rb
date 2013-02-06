def login(member)
  visit "/login"
  click_link('log in')
  fill_the_following({
      "email" => @member.email,
      "password" => 'password1'
  })
  click_button('Log in')
end

def select_date(field, date, options = {})
  find(:xpath, '//select[contains(@id, "_1i")]').find(:xpath, ::XPath::HTML.option(date.year.to_s)).select_option
  find(:xpath, '//select[contains(@id, "_2i")]').find(:xpath, ::XPath::HTML.option(date.strftime('%B').to_s)).select_option
  find(:xpath, '//select[contains(@id, "_3i")]').find(:xpath, ::XPath::HTML.option(date.day.to_s)).select_option
end

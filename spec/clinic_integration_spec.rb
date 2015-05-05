require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

# DB = PG.connect({:dbname => 'test_clinic'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM patients *;")
    DB.exec("DELETE FROM doctors *;")
  end
end

describe('the clinic path', {:type => :feature}) do
  it('will visit the homepage and view the administrator page') do
    visit('/')
    click_on('Administrator')
    expect(page).to have_content('Here is a list of doctors at this clinic:')
    click_on('Home')
    expect(page).to have_content('Please identify yourself:')
  end

  it('will visit the homepage and view the doctor page') do
    visit('/')
    click_on('Doctor')
    expect(page).to have_content('Here is a list of your patients at this clinic:')
    click_on('Home')
    expect(page).to have_content('Please identify yourself:')
  end

  it('will visit the homepage and view the patient page') do
    visit('/')
    click_on('Patient')
    expect(page).to have_content('Here is a list of doctors at this clinic:')
    expect(page).to have_content('Your doctor is:')
        click_on('Home')
    expect(page).to have_content('Please identify yourself:')
  end

end

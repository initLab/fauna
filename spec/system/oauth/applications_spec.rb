require "rails_helper"

feature "Managing OAuth applications" do
  def create_a_new_oauth_application
    visit oauth_applications_path
    click_on "Ново приложение", match: :first
    fill_in "Име", with: "Test App"
    fill_in "УРИ за обратна връзка", with: "urn:ietf:wg:oauth:2.0:oob"
    click_on "Създай"
  end

  scenario "creation of a new application" do
    register_a_new_account
    sign_in_with_the_new_account
    create_a_new_oauth_application

    expect(page).to have_text("Приложението беше създадено.")
    expect(page).to have_text("Приложение: Test App")
  end

  scenario "editing of an application" do
    register_a_new_account
    sign_in_with_the_new_account
    create_a_new_oauth_application

    click_on "Промени", match: :first
    fill_in "Име", with: "Test App 2"
    click_on "Обнови"

    expect(page).to have_text("Приложението беше обновено.")
    expect(page).to have_text("Приложение: Test App 2")
  end

  scenario "authorizing a client", js: true do
    register_a_new_account
    sign_in_with_the_new_account
    create_a_new_oauth_application

    new_window = window_opened_by { click_on "Потвърди" }

    within_window new_window do
      click_on "Потвърди"
      expect(page).to have_text("Код за упълномощаване:")
    end
  end

  scenario "deleting an application" do
    register_a_new_account
    sign_in_with_the_new_account
    create_a_new_oauth_application

    click_on "Премахни", match: :first
    expect(page).to have_text("Приложението беше премахнато.")
    expect(page).to_not have_text("Test App")
  end
end

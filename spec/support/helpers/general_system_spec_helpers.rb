module GeneralSystemSpecHelpers
  def register_a_new_account
    visit root_path
    click_on "Вход"
    click_on "Регистрация"
    fill_in "Потребителско име", with: "foo"
    fill_in "Име", with: "foo", match: :first
    fill_in "Имейл", with: "foo@example.com"
    fill_in "Парола", with: "123qweASD"
    fill_in "Потвърждение на парола", with: "123qweASD"
    click_on "Регистрирай ме"
    visit user_confirmation_path(confirmation_token: User.find_by(email: "foo@example.com").confirmation_token)
  end

  def sign_in_with_the_new_account
    fill_in "Потребителско име или Email", with: "foo"
    fill_in "Парола", with: "123qweASD"
    click_on "Влез"
  end
end

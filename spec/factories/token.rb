FactoryBot.define do
  factory :access_token, class: "Doorkeeper::AccessToken" do
    application
  end
end

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "*"

    resource "/api/*",
      headers: :any,
      methods: [:post, :put, :delete, :get, :patch, :options]
    resource "/oauth/token",
      headers: :any,
      methods: [:post]
    resource "/oauth/revoke",
      headers: :any,
      methods: [:post]
  end
end

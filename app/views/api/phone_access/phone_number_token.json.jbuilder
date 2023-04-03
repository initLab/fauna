json.user do
  json.name @user.name
end

json.auth_token do
  json.token @auth_token.token
  json.expires_at @auth_token.expires_at
end

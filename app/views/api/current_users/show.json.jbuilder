json.extract! @current_user, :id, :name, :first_name, :last_name, :url, :twitter, :username, :github, :jabber, :picture, :locale, :announce_my_presence
json.roles @current_user.roles.map(&:name)

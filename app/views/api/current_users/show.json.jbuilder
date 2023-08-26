json.extract! @current_user, :id, :name, :url, :twitter, :username, :github, :jabber, :picture, :locale
json.roles @current_user.roles.map(&:name)

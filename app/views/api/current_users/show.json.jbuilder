json.extract! @current_user, :id, :name, :url, :twitter, :username, :github, :jabber, :picture
json.roles @current_user.roles.map(&:name)

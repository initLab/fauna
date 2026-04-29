# frozen_string_literal: true

json.extract! @current_user, :id, :email, :name, :first_name, :last_name, :username,
              :url, :twitter, :github, :jabber,
              :picture, :locale, :announce_my_presence
json.roles @current_user.roles.map(&:name)

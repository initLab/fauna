class User < ActiveRecord::Base
end

class AddDefaultLocaleToAllUsers < ActiveRecord::Migration[4.2]
  def change
    User.where(locale: nil).update_all(locale: 'bg')
  end
end

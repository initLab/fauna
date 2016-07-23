class Presence
  def self.present_users
    RadWho.new.present_users
  end
end

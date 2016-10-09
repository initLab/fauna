class Presence
  def self.present_users
    (Arp.present_users + RadWho.new.present_users).uniq
  end
end

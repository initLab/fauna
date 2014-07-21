class Device < ActiveRecord::Base
  # The names of the table and the foreign key are like this so we don't break
  # existing scripts
  self.table_name = "objects"
  belongs_to :owner, class_name: 'User', foreign_key: 'userid'

  validates :userid, presence: true
  validates :value, presence: true

  def self.find_sti_class(type_name)
    {'mac' => Computer}[type_name]
  end
end

class Door::Actions::Action < ActiveRecord::Base
  self.abstract_class = true

  belongs_to :initiator

  def execute!
    raise NotImplementedError
  end
end

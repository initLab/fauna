class Door::Actions::Action < ActiveRecord::Base

  belongs_to :initiator

  def execute!
    raise NotImplementedError
  end
end

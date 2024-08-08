class SpaceApi < OpenStruct
  include ActiveModel::Serializers::JSON
  include ActionView::Helpers::AssetUrlHelper

  def initialize
    super(SPACEAPI_CONFIG)
    self.api = "0.13"
    set_hackerspace_state
    add_people_now_present
  end

  def attributes
    to_h
  end

  private

  def add_sensor(name:, data:)
    self.sensors ||= {}
    self.sensors[name] ||= []

    self.sensors[name] << data
  end

  def add_people_now_present
    present_people_reading = {location: SPACEAPI_CONFIG["space"],
                              value: Presence.present_users.count}

    if Presence.present_users.count > 0
      present_people_reading[:names] = Presence.present_users.map(&:username)
    end

    add_sensor name: :people_now_present, data: present_people_reading
  end

  def set_hackerspace_state
    self.state = {open: false} # TODO: Implement this
  end
end

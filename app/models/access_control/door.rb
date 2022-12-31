class AccessControl::Door
  include ActiveModel::Model

  attr_reader :id

  def initialize(params)
    @id = params[:id]

    @localized_names = params[:human_name]

    @action_permissions = params[:actions].transform_values { _1[:roles] }

    params[:controller].tap do |controller_config|
      @controller =
        AccessControl::DoorControllers
          .const_get(controller_config[:klass])
          .new(**(controller_config[:options] || {}))
    end
  end

  def self.all
    door_config.keys.map { find(_1) }
  end

  def self.find(id)
    new(**door_config[id].merge(id: id) || raise(ArgumentError, "No such door defined: #{id}"))
  end

  def human_name(locale: I18n.locale)
    @localized_names[locale]
  end

  def supported_actions
    @action_permissions.keys
  end

  def supported_actions_for(*roles)
    supported_actions.select { |action| permitted_roles_for(action).any? { |role| roles.include?(role) } }
  end

  def perform_action(action)
    raise(ArgumentError, "Door does not support action: #{action.inspect}") unless @action_permissions.key?(action)

    @controller.call(action)
  end

  def permitted_roles_for(action)
    raise(ArgumentError, "Door does not support action: #{action.inspect}") unless @action_permissions.key?(action)

    @action_permissions[action]
  end

  def self.door_config
    Rails.application.config.x.doors
  end

  private_class_method :door_config, :new
end

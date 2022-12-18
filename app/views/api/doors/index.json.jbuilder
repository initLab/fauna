json.array! @doors do |door|
  json.id door.id
  json.name door.human_name
  json.supported_actions door.supported_actions.select { door.permitted_roles_for(_1).any? { |role| current_resource_owner.has_role?(role) } }
end

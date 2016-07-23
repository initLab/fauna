ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :role_ids

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column :roles_description do |u|
      u.roles.map(&:name).join(', ')
    end
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end

# frozen_string_literal: true
crumb :dashboard do
  link 'Dashboard', admin_root_path
end

crumb :administrators do
  link 'Administrators', admin_administrators_path
  parent :dashboard
end

crumb :new_administrator do
  link 'New Administrator', new_admin_administrator_path
  parent :administrators
end

crumb :edit_administrator do |admin|
  link "Edit Administrator: #{admin.full_name}", edit_admin_administrator_path(admin)
  parent :administrators
end

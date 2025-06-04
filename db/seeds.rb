# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

controlled_resources = [:offices, :jobs, :acas, :acas_download_logs,
  :addresses, :claims, :claimants, :exports, :exported_files,
  :roles, :representatives, :respondents, :responses, :uploaded_files, :users,
  :acas_check_digits, :reference_number_generators]

permissions = [:create, :read, :update, :delete, :import].product(controlled_resources).map { |pair| pair.join('_') }.sort

permissions.each do |p|
  Admin::Permission.find_or_create_by! name: p
end

admin_role = Admin::Role.find_or_create_by!(name: 'Admin', is_admin: true)
super_user_role = Admin::Role.find_or_create_by!(name: 'Super User')
developer_role = Admin::Role.find_or_create_by!(name: 'Developer')
user_role = Admin::Role.find_or_create_by!(name: 'User')

Admin::Role.find_by!(name: 'Super User').tap do |role|
  permission_names = role.permissions.map(&:name)
  role.permissions << Admin::Permission.find_by(name: 'read_offices') unless permission_names.include?('read_offices')
  role.permissions << Admin::Permission.find_by(name: 'update_offices') unless permission_names.include?('update_offices')
  role.permissions << Admin::Permission.find_by(name: 'delete_offices') unless permission_names.include?('delete_offices')
  role.permissions << Admin::Permission.find_by(name: 'create_offices') unless permission_names.include?('create_offices')
  role.permissions << Admin::Permission.find_by(name: 'read_acas') unless permission_names.include?('read_acas')
  role.permissions << Admin::Permission.find_by(name: 'read_acas_download_logs') unless permission_names.include?('read_acas_download_logs')
  role.permissions << Admin::Permission.find_by(name: 'read_acas_check_digits') unless permission_names.include?('read_acas_check_digits')
  role.permissions << Admin::Permission.find_by(name: 'read_reference_number_generators') unless permission_names.include?('read_reference_number_generators')
  role.permissions << Admin::Permission.find_by(name: 'create_reference_number_generators') unless permission_names.include?('create_reference_number_generators')

  role.permissions << Admin::Permission.find_by(name: 'read_claims') unless permission_names.include?('read_claims')
  role.permissions << Admin::Permission.find_by(name: 'update_claims') unless permission_names.include?('update_claims')
  role.permissions << Admin::Permission.find_by(name: 'delete_claims') unless permission_names.include?('delete_claims')
  role.permissions << Admin::Permission.find_by(name: 'create_claims') unless permission_names.include?('create_claims')

  role.permissions << Admin::Permission.find_by(name: 'read_responses') unless permission_names.include?('read_responses')
  role.permissions << Admin::Permission.find_by(name: 'update_responses') unless permission_names.include?('update_responses')
  role.permissions << Admin::Permission.find_by(name: 'delete_responses') unless permission_names.include?('delete_responses')
  role.permissions << Admin::Permission.find_by(name: 'create_responses') unless permission_names.include?('create_responses')

  role.permissions << Admin::Permission.find_by(name: 'read_users') unless permission_names.include?('read_users')
  role.permissions << Admin::Permission.find_by(name: 'update_users') unless permission_names.include?('update_users')
  role.permissions << Admin::Permission.find_by(name: 'delete_users') unless permission_names.include?('delete_users')
  role.permissions << Admin::Permission.find_by(name: 'create_users') unless permission_names.include?('create_users')
end

Admin::Role.find_by!(name: 'Developer').tap do |role|
  permission_names = role.permissions.map(&:name)
  role.permissions << Admin::Permission.find_by(name: 'read_offices') unless permission_names.include?('read_offices')
  role.permissions << Admin::Permission.find_by(name: 'update_offices') unless permission_names.include?('update_offices')
  role.permissions << Admin::Permission.find_by(name: 'delete_offices') unless permission_names.include?('delete_offices')
  role.permissions << Admin::Permission.find_by(name: 'create_offices') unless permission_names.include?('create_offices')

  role.permissions << Admin::Permission.find_by(name: 'read_addresses') unless permission_names.include?('read_addresses')
  role.permissions << Admin::Permission.find_by(name: 'update_addresses') unless permission_names.include?('update_addresses')
  role.permissions << Admin::Permission.find_by(name: 'delete_addresses') unless permission_names.include?('delete_addresses')
  role.permissions << Admin::Permission.find_by(name: 'create_addresses') unless permission_names.include?('create_addresses')

  role.permissions << Admin::Permission.find_by(name: 'read_claims') unless permission_names.include?('read_claims')
  role.permissions << Admin::Permission.find_by(name: 'update_claims') unless permission_names.include?('update_claims')
  role.permissions << Admin::Permission.find_by(name: 'delete_claims') unless permission_names.include?('delete_claims')
  role.permissions << Admin::Permission.find_by(name: 'create_claims') unless permission_names.include?('create_claims')

  role.permissions << Admin::Permission.find_by(name: 'read_responses') unless permission_names.include?('read_responses')
  role.permissions << Admin::Permission.find_by(name: 'update_responses') unless permission_names.include?('update_responses')
  role.permissions << Admin::Permission.find_by(name: 'delete_responses') unless permission_names.include?('delete_responses')
  role.permissions << Admin::Permission.find_by(name: 'create_responses') unless permission_names.include?('create_responses')

  role.permissions << Admin::Permission.find_by(name: 'read_claimants') unless permission_names.include?('read_claimants')
  role.permissions << Admin::Permission.find_by(name: 'update_claimants') unless permission_names.include?('update_claimants')
  role.permissions << Admin::Permission.find_by(name: 'delete_claimants') unless permission_names.include?('delete_claimants')
  role.permissions << Admin::Permission.find_by(name: 'create_claimants') unless permission_names.include?('create_claimants')

  role.permissions << Admin::Permission.find_by(name: 'read_representatives') unless permission_names.include?('read_representatives')
  role.permissions << Admin::Permission.find_by(name: 'update_representatives') unless permission_names.include?('update_representatives')
  role.permissions << Admin::Permission.find_by(name: 'delete_representatives') unless permission_names.include?('delete_representatives')
  role.permissions << Admin::Permission.find_by(name: 'create_representatives') unless permission_names.include?('create_representatives')

  role.permissions << Admin::Permission.find_by(name: 'read_respondents') unless permission_names.include?('read_respondents')
  role.permissions << Admin::Permission.find_by(name: 'update_respondents') unless permission_names.include?('update_respondents')
  role.permissions << Admin::Permission.find_by(name: 'delete_respondents') unless permission_names.include?('delete_respondents')
  role.permissions << Admin::Permission.find_by(name: 'create_respondents') unless permission_names.include?('create_respondents')

  role.permissions << Admin::Permission.find_by(name: 'read_uploaded_files') unless permission_names.include?('read_uploaded_files')
  role.permissions << Admin::Permission.find_by(name: 'update_uploaded_files') unless permission_names.include?('update_uploaded_files')
  role.permissions << Admin::Permission.find_by(name: 'delete_uploaded_files') unless permission_names.include?('delete_uploaded_files')
  role.permissions << Admin::Permission.find_by(name: 'create_uploaded_files') unless permission_names.include?('create_uploaded_files')

  role.permissions << Admin::Permission.find_by(name: 'read_acas') unless permission_names.include?('read_acas')
  role.permissions << Admin::Permission.find_by(name: 'read_acas_download_logs') unless permission_names.include?('read_acas_download_logs')
  role.permissions << Admin::Permission.find_by(name: 'read_acas_check_digits') unless permission_names.include?('read_acas_check_digits')
  role.permissions << Admin::Permission.find_by(name: 'read_jobs') unless permission_names.include?('read_jobs')
  role.permissions << Admin::Permission.find_by(name: 'read_reference_number_generators') unless permission_names.include?('read_reference_number_generators')
  role.permissions << Admin::Permission.find_by(name: 'create_reference_number_generators') unless permission_names.include?('create_reference_number_generators')
end

Admin::Role.find_by!(name: 'User').tap do |role|
  permission_names = role.permissions.map(&:name)
  role.permissions << Admin::Permission.find_by(name: 'read_offices') unless permission_names.include?('read_offices')
  role.permissions << Admin::Permission.find_by(name: 'read_acas_download_logs') unless permission_names.include?('read_acas_download_logs')
  role.permissions << Admin::Permission.find_by(name: 'read_acas') unless permission_names.include?('read_acas')
  role.permissions << Admin::Permission.find_by(name: 'read_acas_check_digits') unless permission_names.include?('read_acas_check_digits')
  role.permissions << Admin::Permission.find_by(name: 'read_reference_number_generators') unless permission_names.include?('read_reference_number_generators')
  role.permissions << Admin::Permission.find_by(name: 'create_reference_number_generators') unless permission_names.include?('create_reference_number_generators')
end


if Rails.env.development? || ENV.fetch('SEED_EXAMPLE_USERS', 'false') == 'true'
  Admin::User.find_or_create_by!(email: 'admin@example.com') do |user|
    user.name = 'Administrator'
    user.department = 'DCD'
    user.username = 'admin'
    user.password = 'password'
    user.password_confirmation = 'password'
    user.roles << admin_role unless user.roles.include?(admin_role)
  end

  Admin::User.find_or_create_by!(email: 'developer@example.com') do |user|
    user.name = 'Developer'
    user.department = 'DCD'
    user.username = 'developer'
    user.password = 'password'
    user.password_confirmation = 'password'
    user.roles << developer_role unless user.roles.include?(developer_role)
  end

  Admin::User.find_or_create_by!(email: 'superuser@example.com') do |user|
    user.name = 'Super User'
    user.department = 'DCD'
    user.username = 'superuser'
    user.password = 'password'
    user.password_confirmation = 'password'
    user.roles << super_user_role unless user.roles.include?(super_user_role)
  end

  Admin::User.find_or_create_by!(email: 'user@example.com') do |user|
    user.name = 'User'
    user.department = 'DCD'
    user.username = 'user'
    user.password = 'password'
    user.password_confirmation = 'password'
    user.roles << user_role unless user.roles.include?(user_role)
  end
end

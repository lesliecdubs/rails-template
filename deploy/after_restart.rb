# frozen_string_literal: true
notify_deploy_environments = %w(staging production)
notify_deploy_roles        = %w(solo app_master)

if notify_deploy_environments.include?(config.environment) && notify_deploy_roles.include?(config.current_role)
  run "cd #{config.current_path} && bundle exec honeybadger deploy -e #{config.environment} -s #{config.revision} -u `whoami` -r #{config.repo}"
end

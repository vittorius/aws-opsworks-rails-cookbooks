node[:deploy].each do |application, deploy|
  rails_env = deploy[:rails_env]
  current_path = deploy[:current_path]

  Chef::Log.info("Restarting Delayed::Job workers with environment #{rails_env}")

  execute 'delayed_job restart' do
    cwd current_path
    user 'deploy'
    command 'bin/delayed_job restart'
    environment 'RAILS_ENV' => rails_env
  end
end
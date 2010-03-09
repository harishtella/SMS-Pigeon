load 'deploy' if respond_to?(:namespace) # cap2 differentiator
load 'config/deploy'

namespace :deploy do
  task :start, :roles => :app do
    run "sudo /etc/init.d/nginx restart"
  end
   
  task :restart, :roles => :app do
    run "sudo /etc/init.d/nginx restart"
  end

  task :stop, :roles => :app do 
    run "sudo /etc/init.d/nginx stop"
  end

  after "deploy:symlink" do
  end
end


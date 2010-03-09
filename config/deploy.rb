set :application, "web_interface"
set :user, "harish"
set :domain, "cpmtxt.selfip.com"
set :ssh_options, {:forward_agent => true, :port => 6666} 

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:

# If you aren't using Subversion to manage your source code, specify
# your SCM below:

set :repository,
"harisht@harishtella.info:/home/harisht/git/cpmtxt_rails.git"
set :scm, "git"
set :branch, "master"

set :use_sudo, false
set :deploy_to, "/var/www/txtmsg/"
set :deploy_via, :checkout
set :group_writable, false 

default_run_options[:pty] = true

role :app, domain 
role :web, domain
role :db,  domain, :primary => true


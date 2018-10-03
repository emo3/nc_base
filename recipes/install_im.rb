# Create the dir's that are needed by installation Manager
directory node['nc_base']['im_dir'] do
  user node['nc_base']['nc_act']
  group node['nc_base']['nc_grp']
  not_if { File.exist?("#{node['nc_base']['app_dir']}/InstallationManager/eclipse/IBMIM") }
  recursive true
  mode '0755'
end

# Download the object server package file
remote_file "#{node['nc_base']['im_dir']}/#{node['nc_base']['im_pkg']}" do
  source "#{node['nc_base']['media_url']}/#{node['nc_base']['im_pkg']}"
  not_if { File.exist?("#{node['nc_base']['im_dir']}/#{node['nc_base']['im_pkg']}") }
  not_if { File.exist?("#{node['nc_base']['im_dir']}/userinstc") }
  not_if { File.exist?("#{node['nc_base']['app_dir']}/InstallationManager/eclipse/IBMIM") }
  user node['nc_base']['nc_act']
  group node['nc_base']['nc_grp']
  mode '0755'
  action :create
end

# unzip the object server package file
execute 'unzip_package' do
  command "unzip -q #{node['nc_base']['im_dir']}/#{node['nc_base']['im_pkg']}"
  cwd node['nc_base']['im_dir']
  not_if { File.exist?("#{node['nc_base']['im_dir']}/userinstc") }
  not_if { File.exist?("#{node['nc_base']['app_dir']}/InstallationManager/eclipse/IBMIM") }
  user node['nc_base']['nc_act']
  group node['nc_base']['nc_grp']
  umask '022'
  action :run
end

# Change ownership of directories
directory node['nc_base']['app_dir'] do
  user node['nc_base']['nc_act']
  group node['nc_base']['nc_grp']
  mode '0755'
  recursive true
  action :create
end

# Install Installation Manager
execute 'install_im' do
  command "#{node['nc_base']['im_dir']}/userinstc \
  -acceptlicense \
  -accessRights nonAdmin \
  -installationDirectory #{node['nc_base']['app_dir']}/InstallationManager \
  -log #{node['nc_base']['temp_dir']}/install-im_log.xml"
  cwd node['nc_base']['im_dir']
  not_if { File.exist?("#{node['nc_base']['app_dir']}/InstallationManager/eclipse/IBMIM") }
  user node['nc_base']['nc_act']
  group node['nc_base']['nc_grp']
  umask '022'
  action :run
end

template '/etc/profile.d/im.sh' do
  source 'im.sh.erb'
  mode 0755
end

directory node['nc_base']['im_dir'] do
  only_if { File.exist?("#{node['nc_base']['app_dir']}/InstallationManager/eclipse/IBMIM") }
  recursive true
  action :delete
end

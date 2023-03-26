# Download the object server package file
remote_file "#{Chef::Config[:file_cache_path]}/#{node['nc_base']['im_pkg']}" do
  source "#{node['nc_base']['media_url']}/#{node['nc_base']['im_pkg']}"
  user node['nc_base']['nc_act']
  group node['nc_base']['nc_grp']
  mode '0755'
  action :create
end

# unzip the object server package file
archive_file "#{Chef::Config[:file_cache_path]}/#{node['nc_base']['im_pkg']}" do
  destination node['nc_base']['im_dir']
  action :extract
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
  not_if { ::File.exist?("#{node['nc_base']['app_dir']}/InstallationManager/eclipse/IBMIM") }
  user node['nc_base']['nc_act']
  group node['nc_base']['nc_grp']
  umask '022'
  action :run
end

template '/etc/profile.d/im.sh' do
  source 'im.sh.erb'
  mode '0755'
end

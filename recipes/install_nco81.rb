# Download the object server package file
remote_file "#{Chef::Config[:file_cache_path]}/#{node['nc_base']['package']}" do
  source "#{node['nc_base']['media_url']}/#{node['nc_base']['package']}"
  user node['nc_base']['nc_act']
  group node['nc_base']['nc_grp']
  mode '0755'
  action :create
end

# unzip the object server package file
archive_file "#{Chef::Config[:file_cache_path]}/#{node['nc_base']['package']}" do
  destination node['nc_base']['install_dir']
  owner node['nc_base']['nc_act']
  group node['nc_base']['nc_grp']
  action :extract
end

template "#{node['nc_base']['temp_dir']}/install_nc81.xml" do
  source 'install_nc81.xml.erb'
  mode '0755'
end

execute 'install_netcool' do
  command "#{node['nc_base']['app_dir']}/InstallationManager/eclipse/tools/imcl \
  input #{node['nc_base']['temp_dir']}/install_nc81.xml \
  -log #{node['nc_base']['temp_dir']}/install-nc81_log.xml \
  -acceptLicense"
  not_if { ::File.exist?("#{node['nc_base']['app_dir']}/netcool/bin/nco_id") }
  user node['nc_base']['nc_act']
  group node['nc_base']['nc_grp']
  umask '022'
  action :run
end

template '/etc/profile.d/nco.sh' do
  source 'nco.sh.erb'
  mode '0755'
end

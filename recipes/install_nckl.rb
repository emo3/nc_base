# Download the netcool knowledge library
remote_file "#{Chef::Config[:file_cache_path]}/NcKL_4.6-im.zip" do
  source "#{node['nc_base']['media_url']}/NcKL_4.6-im.zip"
  user node['nc_base']['nc_act']
  group node['nc_base']['nc_grp']
  mode '0755'
  action :create
end

# unzip the netcool knowledge library
archive_file "#{Chef::Config[:file_cache_path]}/NcKL_4.6-im.zip" do
  destination node['nc_base']['nckl_dir']
  owner node['nc_base']['nc_act']
  group node['nc_base']['nc_grp']
  action :extract
end

template "#{node['nc_base']['temp_dir']}/install_product-nckl.xml" do
  source 'install_nckl.xml.erb'
  mode '0755'
end

# install the netcool knowledge library
execute 'install_nckl' do
  command "#{node['nc_base']['app_dir']}/InstallationManager/eclipse/tools/imcl \
  input #{node['nc_base']['temp_dir']}/install_product-nckl.xml \
  -log #{node['nc_base']['temp_dir']}/install-nckl_log.xml \
  -acceptLicense"
  not_if { ::File.exist?("#{node['nc_base']['app_dir']}/NcKL/advcorr.sql") }
  user node['nc_base']['nc_act']
  group node['nc_base']['nc_grp']
  umask '022'
  action :run
end

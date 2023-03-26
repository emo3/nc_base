# Create the dir's that are needed by netcool knowledge library
directory node['nc_base']['nckl_dir'] do
  user node['nc_base']['nc_act']
  group node['nc_base']['nc_grp']
  recursive true
  mode '0755'
end

# Download the netcool knowledge library
remote_file "#{node['nc_base']['nckl_dir']}/NcKL_4.6-im.zip" do
  source "#{node['nc_base']['media_url']}/NcKL_4.6-im.zip"
  not_if { ::File.exist?("#{node['nc_base']['nckl_dir']}/repository.xml") }
  user node['nc_base']['nc_act']
  group node['nc_base']['nc_grp']
  mode '0755'
  action :create
end

# unzip the netcool knowledge library
archive_file 'unzip_nckl' do
  path "#{node['nc_base']['nckl_dir']}/NcKL_4.6-im.zip"
  destination node['nc_base']['nckl_dir']
  owner node['nc_base']['nc_act']
  group node['nc_base']['nc_grp']
  mode '0644'
end

template "#{node['nc_base']['temp_dir']}/install_product-nckl.xml" do
  source 'install_nckl.xml.erb'
  not_if { ::File.exist?("#{node['nc_base']['app_dir']}/NcKL/advcorr.sql") }
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

file "#{node['nc_base']['temp_dir']}/install_product-nckl.xml" do
  action :delete
end

# remove temporary netcool knowledge library
directory node['nc_base']['nckl_dir'] do
  recursive true
  action :delete
end

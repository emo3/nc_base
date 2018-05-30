# Create the dir's that are needed by netcool update
directory node['nc_base']['fp_dir'] do
  user node['nc_base']['nc_act']
  group node['nc_base']['nc_grp']
  not_if { File.exist?("#{node['nc_base']['nc_dir']}/omnibus/etc/default/update81fp13to81fp15.sql") }
  recursive true
  mode '0755'
end

# Download the object server fix pack file
remote_file "#{node['nc_base']['fp_dir']}/#{node['nc_base']['fp_pkg']}" do
  source "#{node['nc_base']['media_url']}/#{node['nc_base']['fp_pkg']}"
  not_if { File.exist?("#{node['nc_base']['fp_dir']}/#{node['nc_base']['fp_pkg']}") }
  not_if { File.exist?("#{node['nc_base']['nc_dir']}/omnibus/etc/default/update81fp13to81fp15.sql") }
  user node['nc_base']['nc_act']
  group node['nc_base']['nc_grp']
  mode '0755'
  action :create
end

# unzip the object server fix pack file
execute 'unzip_fp_package' do
  command "unzip -q #{node['nc_base']['fp_dir']}/#{node['nc_base']['fp_pkg']}"
  cwd node['nc_base']['fp_dir']
  not_if { File.exist?("#{node['nc_base']['fp_dir']}/update_gui.sh") }
  not_if { File.exist?("#{node['nc_base']['nc_dir']}/omnibus/etc/default/update81fp13to81fp15.sql") }
  user node['nc_base']['nc_act']
  group node['nc_base']['nc_grp']
  umask '022'
  action :run
end

template "#{node['nc_base']['temp_dir']}/update_nc81fp.xml" do
  not_if { File.exist?("#{node['nc_base']['nc_dir']}/omnibus/etc/default/update81fp13to81fp15.sql") }
  source 'update_nc81fp.xml.erb'
  mode 0755
end

execute 'update_netcool' do
  command "#{node['nc_base']['app_dir']}/InstallationManager/eclipse/tools/imcl \
  input #{node['nc_base']['temp_dir']}/update_nc81fp.xml \
  -log #{node['nc_base']['temp_dir']}/update-nc81_log.xml \
  -acceptLicense"
  not_if { File.exist?("#{node['nc_base']['nc_dir']}/omnibus/etc/default/update81fp13to81fp15.sql") }
  user node['nc_base']['nc_act']
  group node['nc_base']['nc_grp']
  umask '022'
  action :run
end

file "#{node['nc_base']['temp_dir']}/update_nc81fp.xml" do
  only_if { File.exist?("#{node['nc_base']['nc_dir']}/omnibus/etc/default/update81fp13to81fp15.sql") }
  action :delete
end

directory node['nc_base']['fp_dir'] do
  only_if { File.exist?("#{node['nc_base']['nc_dir']}/omnibus/etc/default/update81fp13to81fp15.sql") }
  recursive true
  action :delete
end

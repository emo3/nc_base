# Download the object server fix pack file
remote_file "#{Chef::Config[:file_cache_path]}/#{node['nc_base']['fp_pkg']}" do
  source "#{node['nc_base']['media_url']}/#{node['nc_base']['fp_pkg']}"
  user node['nc_base']['nc_act']
  group node['nc_base']['nc_grp']
  mode '0755'
  action :create
end

# unzip the object server fix pack file
archive_file "#{Chef::Config[:file_cache_path]}/#{node['nc_base']['fp_pkg']}" do
  destination node['nc_base']['fp_dir']
  owner node['nc_base']['nc_act']
  group node['nc_base']['nc_grp']
  action :extract
end

template "#{node['nc_base']['temp_dir']}/update_nc81fp.xml" do
  source 'update_nc81fp.xml.erb'
  mode '0755'
end

execute 'update_netcool' do
  command "#{node['nc_base']['app_dir']}/InstallationManager/eclipse/tools/imcl \
  input #{node['nc_base']['temp_dir']}/update_nc81fp.xml \
  -log #{node['nc_base']['temp_dir']}/update-nc81_log.xml \
  -acceptLicense"
  not_if { ::File.exist?("#{node['nc_base']['nc_dir']}/omnibus/etc/default/update81fp13to81fp15.sql") }
  user node['nc_base']['nc_act']
  group node['nc_base']['nc_grp']
  umask '022'
  action :run
end

# Download the java security file
remote_file "#{node['nc_base']['temp_dir']}/java.security" do
  source "#{node['nc_base']['media_url']}/java.security"
  user node['nc_base']['nc_act']
  group node['nc_base']['nc_grp']
  mode '0755'
  action :create
end

template "#{node['nc_base']['temp_dir']}/fix_java.sh" do
  source 'fix_java.sh.erb'
  mode '0755'
end

execute 'Configure_JRE' do
  command "#{node['nc_base']['temp_dir']}/fix_java.sh"
  not_if { ::File.exist?("#{node['nc_base']['app_dir']}/netcool/platform/linux2x86/jre64_1.8.0/jre/lib/security/java.security.orig") }
  user node['nc_base']['nc_act']
  group node['nc_base']['nc_grp']
  action :run
end

# create fips.conf file for TLS 1.2 security
template "#{node['nc_base']['nc_dir']}/etc/security/fips.conf" do
  source 'fips.conf.erb'
  user node['nc_base']['nc_act']
  group node['nc_base']['nc_grp']
  mode 0444
end

# Download the password key file
remote_file "#{node['nc_base']['ob_dir']}/etc/passwdkey.key" do
  source "#{node['nc_base']['media_url']}/passwdkey.key"
  not_if { File.exist?("#{node['nc_base']['ob_dir']}/etc/passwdkey.key") }
  user node['nc_base']['nc_act']
  group node['nc_base']['nc_grp']
  mode 0440
  action :create
end

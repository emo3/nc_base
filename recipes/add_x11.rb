# This will allow X11 forwarding for this server
template '/etc/ssh/sshd_config' do
  source 'sshd_config.erb'
  mode '0644'
end

service 'sshd' do
  action :restart
end

# add x11 package(s)
package node['nc_base']['rhel_x11']

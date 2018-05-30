# create netcool admin group
group node['nc_base']['nc_grp'] do
  action :create
end

# create netcool admin account
user node['nc_base']['nc_act'] do
  gid node['nc_base']['nc_grp']
  shell '/bin/bash'
  password node['nc_base']['nc_epwd']
  manage_home true
  action :create
end

# Add group vagrant to netcool account
group 'vagrant' do
  members node['nc_base']['nc_act']
  action :modify
  append true
end

# Add netcool admin group account to root
group node['nc_base']['nc_grp'] do
  members 'root'
  action :modify
  append true
end

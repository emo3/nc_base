# remove any extra repos from yum.repos.d
execute 'remove_repos' do
  command 'rm -f /etc/yum.repos.d/CentOS*'
  cwd '/usr/bin'
  only_if { ::File.exist? '/etc/yum.repos.d/CentOS-Base.repo' }
  action :run
end

# make sure we have the latest RHEL versions
execute 'update_RHEL' do
  command 'yum -y -q update'
  action :run
end

#######################################
# The following was taken from the PreRequisite Scanner
# begin PRS Section

# Install RPM's
package node['nc_base']['rhel']

# set ulimits needed for netcool
## Create file to hold limits
limits_file '/etc/security/limits.conf' do
  action :create
end

## max number of processes
limit 'limit-processes-hard' do
  type 'hard'
  item 'nproc'
  value 'unlimited'
end

limit 'limit-processes-soft' do
  type 'soft'
  item 'nproc'
  value 'unlimited'
end

## max number of open file descriptors
limit 'limit-files-hard' do
  type 'hard'
  item 'nofile'
  value 33000
end

limit 'limit-files-soft' do
  type 'soft'
  item 'nofile'
  value 33000
end

## limits the core file size (KB)
limit 'limit-core-hard' do
  type 'hard'
  item 'core'
  value 390001
end

limit 'limit-core-soft' do
  type 'soft'
  item 'core'
  value 390001
end

## maximum filesize (KB)
limit 'limit-filesize-soft' do
  type 'soft'
  item 'fsize'
  value 'unlimited'
end

## max stack file size
limit 'limit-stack-soft' do
  type 'soft'
  item 'stack'
  value 'unlimited'
end

# make sure ntp is up and running
service 'ntpd' do
  action [:enable, :start]
end

# end PRS Section
#######################################

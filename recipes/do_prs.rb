# Install the RHEL package bc
package %w(bc)

# Create PRS directory
directory node['nc_base']['prs_dir'] do
  recursive true
  action :create
end

# Download the prs file
remote_file "#{node['nc_base']['prs_dir']}/#{node['nc_base']['prs']}" do
  source "#{node['nc_base']['media_url']}/#{node['nc_base']['prs']}"
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# Download the prs patch file
remote_file "#{node['nc_base']['prs_dir']}/#{node['nc_base']['prs_patch']}" do
  source "#{node['nc_base']['media_url']}/#{node['nc_base']['prs_patch']}"
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

# untar the prs tar file
archive_file 'untar_package-prs' do
  path "#{node['nc_base']['prs_dir']}/#{node['nc_base']['prs_patch']}"
  destination node['nc_base']['prs_dir']
  not_if { ::File.exist?("#{node['nc_base']['prs_dir']}/prereq_checker.sh") }
  mode '0644'
end

# untar the prs patch gz file
archive_file 'untar_patch-prs' do
  path "#{node['nc_base']['prs_dir']}/#{node['nc_base']['prs_patch']}"
  destination node['nc_base']['prs_dir']
  not_if { ::File.exist?("#{node['nc_base']['prs_dir']}/UNIX_Linux/NOD_07040000.cfg") }
  mode '0644'
end

template "#{node['nc_base']['prs_dir']}/run_prs.sh" do
  source 'prs.sh.erb'
  mode '0755'
end

execute 'run_prs' do
  command "#{node['nc_base']['prs_dir']}/run_prs.sh"
  cwd node['nc_base']['prs_dir']
  not_if { ::File.exist?("#{node['nc_base']['prs_dir']}/all_results.txt") }
  action :run
end

execute 'find_fails' do
  command "grep FAIL #{node['nc_base']['prs_dir']}/all_results.txt>#{node['nc_base']['prs_dir']}/FAIL.txt"
  cwd node['nc_base']['prs_dir']
  not_if { ::File.exist?("#{node['nc_base']['prs_dir']}/FAIL.txt") }
  action :run
end

# print out the FAIL file
results = "#{node['nc_base']['prs_dir']}/FAIL.txt"
ruby_block 'list_results' do
  only_if { ::File.exist?(results) }
  block do
    print "\n"
    File.open(results).each do |line|
      print line
    end
  end
end

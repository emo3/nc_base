default['nc_base']['base_ver']    = '8.1.0'
default['nc_base']['point_ver']   = "#{node['nc_base']['base_ver']}.1"
default['nc_base']['fp_ver']      = '18'
default['nc_base']['fp_pkg']      = "#{node['nc_base']['base_ver']}-TIV-NCOMNIbus-Linux-FP00#{node['nc_base']['fp_ver']}.zip"
default['nc_base']['fp_rel']      = '5.50.81.20181111_0351'
default['nc_base']['package']     = "OMNIbus-v#{node['nc_base']['point_ver']}-Core.linux64.zip"
default['nc_base']['im_ver']      = '1.8.9002.20181015_1517'
default['nc_base']['im_pkg']      = "agent.installer.linux.gtk.x86_64_#{node['nc_base']['im_ver']}.zip"
default['nc_base']['prs']         = '1.2.0.18-Tivoli-PRS-Unix-fp0001.tar'
default['nc_base']['prs_patch']   = 'netcool-prs-IV93620.tar.gz'
default['nc_base']['cots_dir']    = '/cots'
default['nc_base']['app_dir']     = "#{node['nc_base']['cots_dir']}/apps"
default['nc_base']['nc_dir']      = "#{node['nc_base']['app_dir']}/netcool"
default['nc_base']['ob_dir']      = "#{node['nc_base']['nc_dir']}/omnibus"
default['nc_base']['media_dir']   = "#{node['nc_base']['app_dir']}/media"
default['nc_base']['install_dir'] = "#{node['nc_base']['media_dir']}/nco81"
default['nc_base']['fp_dir']      = "#{node['nc_base']['media_dir']}/nco81fp"
default['nc_base']['gate_dir']    = "#{node['nc_base']['media_dir']}/gateways"
default['nc_base']['nckl_dir']    = "#{node['nc_base']['media_dir']}/nckl"
default['nc_base']['temp_dir']    = '/tmp'
default['nc_base']['prs_dir']     = '/tmp/prs'
default['nc_base']['im_dir']      = '/tmp/im'
default['nc_base']['media_url']   = 'http://10.1.1.30/media'
default['nc_base']['rhel']        = %w(bc ntp firefox unzip)
default['nc_base']['rhel_x11']    = %w(bc ntp firefox compat-libstdc++-33.i686 libXtst.i686 compat-libstdc++-33 compat-db libXp libXmu libXtst pam libXft gtk2 xauth motif xclock)
default['nc_base']['nc_act']      = 'netcool'
default['nc_base']['nc_grp']      = 'ncoadmin'
default['nc_base']['nc_pwd']      = 'P@ssw0rd'
default['nc_base']['nc_epwd']     = '$1$xaVDw1NS$NmyxP1YTnqenTM8LmEO2f.'
default['nc_base']['prs_codes']   = %w(DSH ESS FAS FRS NCM NOA NOC NOD NOP NOS NOW NPA ODP PAD PAM PAW TCR TIP)

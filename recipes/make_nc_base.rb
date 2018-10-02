# fix anything with RHEL that is needed for netcool
include_recipe '::fix_nc_base'
# create netcool accounts
include_recipe '::create_nc_acct'
# install installation Manager
include_recipe '::install_im'
# install base netcool
include_recipe '::install_nco81'
# Update Netcool to latest fix pack
include_recipe '::update_nco81'
# setup the netcool base
include_recipe '::setup_nc_base'

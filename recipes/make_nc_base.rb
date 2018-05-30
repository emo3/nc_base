# fix anything with RHEL that is needed for netcool
include_recipe '::fix_nc_base'
# install base netcool
include_recipe '::install_nco81'
# Update Netcool to latest fix pack
include_recipe '::update_nco81'
# setup the netcool base
include_recipe '::setup_nc_base'

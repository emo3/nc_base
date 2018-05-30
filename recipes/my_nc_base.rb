# This is a recipe that will do what I want setup
include_recipe '::create_nc_acct'
include_recipe '::nc_filesystem'
include_recipe '::install_im'
include_recipe '::make_nc_base'
# include_recipe '::add_x11'
include_recipe '::install_nckl'

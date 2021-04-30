name 'nc_base'
maintainer 'Ed Overton'
maintainer_email 'bogus@gmail.com'
license 'Apache 2.0'
description 'Installs/Configures nc_base'
long_description 'Installs/Configures nc_base'
version '0.5.0'
chef_version '>= 13.0'
supports 'redhat'

issues_url 'https://github.com/emo3/nc_base/issues' if respond_to?(:issues_url)
source_url 'https://github.com/emo3/nc_base'

depends 'server_utils'
depends 'limits'
depends 'selinux'

maintainer       'OpenStax'
license          'MIT'
description      'Definition for installing SSL certs'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.1'

supports         'ubuntu'

attribute 'ssl_certificates',
  :display_name => 'SSL certificates',
  :description => 'Hash of SSL certificate attributes organized by name.',
  :type => 'hash'
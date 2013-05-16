# Define the following attributes to pin the version of Ruby installed
# by Amazon's recipes.  This content should go into custom JSON on opsworks
node.normal[:opsworks][:ruby_version] = '1.9.3'
node.normal[:ruby][:major_version] = '1.9'
node.normal[:ruby][:full_version] = '1.9.3'
node.normal[:ruby][:patch] = 'p392'
node.normal[:ruby][:pkgrelease] = '1'
node.normal["emacs"]["packages"] = ["emacs23-nox"]
# Gets rid of an apache2 cookbook dependency from unicorn::rails
node.normal["opsworks"]["skip_uninstall_of_other_rails_stack"] = true
node.normal["dependencies"]["update_debs"] = true
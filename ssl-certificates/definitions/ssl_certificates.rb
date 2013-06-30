define :ssl_certificates do
  node[:ssl_certificates].each do |name, certificate_data|

    next if name == 'options'

    directory node[:ssl_certificates][:options][:path] do
      owner node[:ssl_certificates][:options][:owner]
      group node[:ssl_certificates][:options][:group]
      mode node[:ssl_certificates][:options][:file_mode]
    end

    certificate_data.each do |extension, content|
      file "#{node[:ssl_certificates][:options][:path]}/#{name}.#{extension}" do
        content content
        owner node[:ssl_certificates][:options][:owner]
        group node[:ssl_certificates][:options][:group]
        mode node[:ssl_certificates][:options][:file_mode]
      end
    end

  end
end
node.default['php']['version'] = '5.3.20'
node.default['php']['configure_options'] = %W{--with-curl --with-config-file-path=/private/etc --with-mysqli --with-apxs2 --with-mcrypt --enable-soap --with-openssl --enable-zip --enable-bcmath --enable-mbstring --enable-sockets}
node.default['php']['url'] = 'http://us.php.net/distributions'

version = node['php']['version']

unless File.exists? "#{Chef::Config[:file_cache_path]}/php-#{version}.tar.gz" 
  remote_file "#{Chef::Config[:file_cache_path]}/php-#{version}.tar.gz" do
    source "#{node['php']['url']}/php-#{version}.tar.gz"
    checksum node['php']['checksum']
    mode "0644"
  end
end

configure_options = node['php']['configure_options'].join(" ")

bash "build php" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOF
  tar -zxvf php-#{version}.tar.gz
  (cd php-#{version} && ./configure #{configure_options})
  (cd php-#{version} && make -j 9)
  (cd php-#{version} && make install)
  EOF
end

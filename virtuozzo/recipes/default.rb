include_recipe 'centos'

execute "install virtuozzo" do
  command "./vzinstall.bin install --templates=full"
  creates "/etc/sysconfig/vz" 
  cwd "/root"
end

file "/etc/vz.conf.d/vz" do
  owner "root"
  group "root"
  mode "0644"
  action :create
end
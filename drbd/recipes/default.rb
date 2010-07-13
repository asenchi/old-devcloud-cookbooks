include_recipe "lvm"

package "drbd8-utils" do
  action :install
end

template "/etc/drbd.conf" do
  owner "root"
  group "root"
  mode 0644
  source "drbd.conf.erb"
  variables({
    :san1hostname => 'pod1san1',
    :san2hostname => 'pod1san2'
  })
end

execute "create our resources" do
  command "drbdadm create-md all"
end

execute "remove drbd from startup (handled by pacemaker)" do
  command "update-rc.d -f drbd remove"
end
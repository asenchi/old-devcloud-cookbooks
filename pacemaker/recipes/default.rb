include_recipe 'drbd'
include_recipe 'iscsi'

package "pacemaker" do
  action :install
end

execute "enable corosync at start" do
  command "sed -e 's/START=no/START=yes/' -i /etc/defaults/corosync"
end

template "/etc/corosync/corosync.conf" do
  variables({
    :multicast_address => "226.94.1.1",
    :network           => "199.34.121.0"
  })
end

cookbook_file "/etc/corosync/authkey" do
  source "authkey"
  mode "0600"
end

template "/root/crm-main.conf" do
  variables({
    :gateway    => "199.34.121.30"
    :virtual_ip => "199.34.121.29"
  })
end

execute "add in our crm-main configuration" do
  command "crm configure load update /root/crm-main.conf"
end

execute "turn off quorum" do
  execute "crm configure property no-quorom-policy=ignore"
end

template "/root/crm-blades.conf" do
end

execute "add in our blade configurations" do
  command "crm configure load update /root/crm-blades.conf"
end
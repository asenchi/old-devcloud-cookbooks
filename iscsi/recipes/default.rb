
if node[:machine_role] == 'san'
  package "iscsitarget" do
    action :install
  end

  template "/etc/ietd.conf" do
    variables({
      :incoming_username => "engineyard-devcloud"
      :incoming_password => "HAHAEYdev383"
      :outgoing_username => "engineyard-devcloud"
      :incoming_password => "HAHAEYdev384"
    })
  end
end

if node[:machine_role] == 'blade'
  package "iscsi-initiator-utils" do
    action :install
  end
end
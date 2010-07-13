
include_recipe "parted"

package "lvm2" do
  action :upgrade
end

if node[:machine_role] == 'san'
  execute "create pv on device" do
    command "pvcreate /dev/#{node[:san_device]}"
    not_if "pvdisplay"
  end

  execute "create volumne group" do
    command "vgcreate -s 32M  blades /dev/#{node[:san_device]}"
  end

  execute "create our meta data slice" do
    command "lvcreate -L13G -ndrbdmeta blades"
    not_if "vgdisplay|grep blades"
  end

  execute "create our blade slices" do
    command %Q{
      for i in 0{1..9} {10..16}
      do
        lvcreate -L814G -nblade$i blades
      done
    }
    not_if "lvdisplay|grep blade01"
  end
end
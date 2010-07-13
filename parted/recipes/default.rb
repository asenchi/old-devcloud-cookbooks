
if node[:machine_role] == 'san'
  execute "create gpt label" do
    command "parted #{node[:san_device]} mklabel gpt"
  end

  execute "create partition" do
    command "parted #{node[:san_device]} mkpart primary 0 -0"
  end
end
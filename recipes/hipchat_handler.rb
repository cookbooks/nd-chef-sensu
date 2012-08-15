sensu_gem "hipchat"
gem_package "hipchat"

data_bag_key = Chef::EncryptedDataBagItem.load_secret(node['data_bag_key'])
secrets = Chef::EncryptedDataBagItem.load("secrets", node.chef_environment, data_bag_key)

apikey = secrets['hipchat']['token']
room = "Ops"

sensu_handler "hipchat.rb" do
  source "https://raw.github.com/needle-cookbooks/sensu-community-plugins/needle/handlers/notification/hipchat.rb"
  handler_config({ "apikey" => apikey, "room" => room })
  handler_settings({ "type" => "pipe", "command" => "/etc/sensu/handlers/hipchat.rb" })
  owner "sensu"
  group "sensu"
end

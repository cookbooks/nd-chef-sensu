gem_package 'redphone' do
    action :install
end

data_bag_key = Chef::EncryptedDataBagItem.load_secret(node['data_bag_key'])
secrets = Chef::EncryptedDataBagItem.load("secrets", node.chef_environment, data_bag_key)

sensu_handler 'pagerduty.rb' do
  source 'https://raw.github.com/needle-cookbooks/sensu-community-plugins/needle/handlers/notification/pagerduty.rb'
  handler_config({"api_key" => secrets['pagerduty_api_key']})
  handler_settings({ "type" => "pipe", "command" => "/etc/sensu/handlers/pagerduty.rb" })
  owner "sensu"
  group "sensu"
end

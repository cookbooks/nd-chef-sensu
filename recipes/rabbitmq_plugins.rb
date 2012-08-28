gem_package 'carrot-top'

plugins = {
    "rabbitmq-alive.rb" => "https://raw.github.com/needle-cookbooks/sensu-community-plugins/needle/plugins/rabbitmq/rabbitmq-alive.rb",
    "rabbitmq-queue-metrics.rb" => "https://raw.github.com/needle-cookbooks/sensu-community-plugins/needle/plugins/rabbitmq/rabbitmq-queue-metrics.rb",
    "rabbitmq-queue-check.rb" => "https://raw.github.com/needle-cookbooks/sensu-community-plugins/needle/plugins/rabbitmq/rabbitmq-queue-check.rb"
}

plugins.each do |name,src|
	sensu_plugin name do
		source src
	end
end

data_bag_key = Chef::EncryptedDataBagItem.load_secret(node['data_bag_key'])
secrets = Chef::EncryptedDataBagItem.load("secrets", node.chef_environment, data_bag_key)

node.sensu.client.rabbit_user = secrets['rabbitmq']['haystack']['username']
node.sensu.client.rabbit_password = secrets['rabbitmq']['haystack']['password']


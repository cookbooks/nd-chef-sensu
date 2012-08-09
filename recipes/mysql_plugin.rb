sensu_gem "mysql2"

mysql_plugins = {
    "mysql-alive.rb" => "https://raw.github.com/needle-cookbooks/sensu-community-plugins/needle/plugins/mysql/mysql-alive.rb",
    "mysql-disk.rb" => "https://raw.github.com/needle-cookbooks/sensu-community-plugins/needle/plugins/mysql/mysql-disk.rb",
    "mysql-graphite.rb" => "https://raw.github.com/needle-cookbooks/sensu-community-plugins/needle/plugins/mysql/mysql-graphite.rb"
}

plugins.each do |name,src|
    sensu_plugin name do
        source src
    end
end

data_bag_key = Chef::EncryptedDataBagItem.load_secret(node['data_bag_key'])
secrets = Chef::EncryptedDataBagItem.load("secrets", node.chef_environment, data_bag_key)

node.sensu.mysql_pass = secrets.database.haystack.password
node.sensu.mysql_user = secrets.database.haystack.username
node.sensu.mysql_host = secrets.database.haystack.host
node.sensu.mysql_instance_name = secrets.database.haystack.instance_id

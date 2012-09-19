sensu_gem "mongo"
sensu_gem "bson_ext"

include_recipe 'python::default'

python_pip "pymongo" do
  action :install
end

sensu_plugin "mongodb-metrics.rb" do
	source "https://raw.github.com/needle-cookbooks/sensu-community-plugins/needle/plugins/mongodb/mongodb-metrics.rb"
end

sensu_plugin "check_mongodb.py" do
    source "https://raw.github.com/needle-cookbooks/nagios-plugin-mongodb/master/check_mongodb.py"
end

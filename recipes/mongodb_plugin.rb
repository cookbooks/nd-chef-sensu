sensu_gem "mongo"
sensu_gem "bson_ext"

sensu_handler "mongodb-metrics.rb" do
  source "https://raw.github.com/needle-cookbooks/sensu-community-plugins/master/plugins/mongodb/mongodb-metrics.rb"
end

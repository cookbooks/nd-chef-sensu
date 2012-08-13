plugins = {
	"es-cluster-status.rb" => "https://raw.github.com/needle-cookbooks/sensu-community-plugins/needle/plugins/elasticsearch/es-cluster-status.rb",
	"check-es-heap.rb" => "https://raw.github.com/needle-cookbooks/sensu-community-plugins/needle/plugins/elasticsearch/check-es-heap.rb"
}

plugins.each do |name,src|
	sensu_plugin name do
		source src
	end
end

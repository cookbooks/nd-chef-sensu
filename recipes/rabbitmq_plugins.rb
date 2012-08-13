gem_package 'carrot-top'

plugins = {
	"rabbitmq-alive.rb" => "https://raw.github.com/needle-cookbooks/sensu-community-plugins/needle/plugins/rabbitmq/rabbitmq-alive.rb",
	"rabbitmq-queue-metrics.rb" => "https://raw.github.com/needle-cookbooks/sensu-community-plugins/needle/plugins/rabbitmq/rabbitmq-queue-metrics.rb"
}

plugins.each do |name,src|
	sensu_plugin name do
		source src
	end
end

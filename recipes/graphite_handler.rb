sensu_handler 'graphite_tcp.rb' do
	source 'https://raw.github.com/sensu/sensu-community-plugins/master/handlers/metrics/graphite-tcp.rb'
	handler_config({ "server" => "", "port" => "" })
	handler_settings({ "type" => "pipe", "command" => "/etc/sensu/handlers/graphite-tcp.rb" })
end
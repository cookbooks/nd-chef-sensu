plugins = {
	"check-http.rb" => "https://raw.github.com/needle-cookbooks/sensu-community-plugins/needle/plugins/http/check-http.rb",
	"check-banner.rb" => "https://raw.github.com/needle-cookbooks/sensu-community-plugins/needle/plugins/network/check-banner.rb"
}

plugins.each do |name,src|
	sensu_plugin name do
		source src
	end
end

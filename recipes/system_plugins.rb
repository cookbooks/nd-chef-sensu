plugins = {
	"check-disk.rb" => "https://raw.github.com/needle-cookbooks/sensu-community-plugins/needle/plugins/system/check-disk.rb",
	"check-load.rb" => "https://raw.github.com/needle-cookbooks/sensu-community-plugins/needle/plugins/system/check-load.rb",
	"check-mem.sh" => "https://raw.github.com/needle-cookbooks/sensu-community-plugins/needle/plugins/system/check-mem.sh",
	"cpu-metrics.rb" => "https://raw.github.com/needle-cookbooks/sensu-community-plugins/needle/plugins/system/cpu-metrics.rb",
	"disk-metrics.rb" => "https://raw.github.com/needle-cookbooks/sensu-community-plugins/needle/plugins/system/disk-metrics.rb",
	"interface-metrics.rb" => "https://raw.github.com/needle-cookbooks/sensu-community-plugins/needle/plugins/system/interface-metrics.rb",
	"memory-metrics.rb" => "https://raw.github.com/needle-cookbooks/sensu-community-plugins/needle/plugins/system/memory-metrics.rb",
	"vmstat-metrics.rb" => "https://raw.github.com/needle-cookbooks/sensu-community-plugins/needle/plugins/system/vmstat-metrics.rb",
	"check_mongodb.py" => "https://raw.github.com/needle-cookbooks/nagios-plugin-mongodb/master/check_mongodb.py",
	"mysql-alive.rb" => "https://raw.github.com/needle-cookbooks/sensu-community-plugins/needle/plugins/mysql/mysql-alive.rb",
	"mysql-disk.rb" => "https://raw.github.com/needle-cookbooks/sensu-community-plugins/needle/plugins/mysql/mysql-disk.rb",
	"mysql-graphite.rb" => "https://raw.github.com/needle-cookbooks/sensu-community-plugins/needle/plugins/mysql/mysql-graphite.rb"
}

plugins.each do |name,src|
	sensu_plugin name do
		source src
	end
end

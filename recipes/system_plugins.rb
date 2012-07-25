plugins {
	"check-disk.rb" => "https://raw.github.com/sensu/sensu-community-plugins/master/plugins/system/check-disk.rb",
	"check-load.rb" => "https://raw.github.com/sensu/sensu-community-plugins/master/plugins/system/check-load.rb",
	"check-mem.sh" => "https://raw.github.com/sensu/sensu-community-plugins/master/plugins/system/check-mem.sh",
	"cpu-metrics.rb" => "https://raw.github.com/sensu/sensu-community-plugins/master/plugins/system/cpu-metrics.rb",
	"disk-metrics.rb" => "https://raw.github.com/sensu/sensu-community-plugins/master/plugins/system/disk-metrics.rb",
	"interface-metrics.rb" => "https://raw.github.com/sensu/sensu-community-plugins/master/plugins/system/interface-metrics.rb",
	"memory-metrics.rb" => "https://raw.github.com/sensu/sensu-community-plugins/master/plugins/system/memory-metrics.rb",
	"vmstat-metrics.rb" => "https://raw.github.com/sensu/sensu-community-plugins/master/plugins/system/vmstat-metrics.rb"
}

plugins.each do |name,src|
	sensu_plugin name do
		source src
	end
end
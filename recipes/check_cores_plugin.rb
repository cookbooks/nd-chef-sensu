plugins = {
    "check_cores.rb" => "https://raw.github.com/needle-cookbooks/sensu-community-plugins/needle/plugins/system/check-cores.rb"
}

plugins.each do |name,src|
    sensu_plugin name do
        source src
    end
end


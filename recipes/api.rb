#
# Cookbook Name:: sensu
# Recipe:: api
#
# Copyright 2011, Sonian Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "sensu::default"

service "sensu-api" do
  provider node.platform =~ /ubuntu|debian/ ? Chef::Provider::Service::Init::Debian : Chef::Provider::Service::Init::Redhat
  supports :status => true, :restart => true
  action [:enable, :start]
  subscribes :restart, resources(:sensu_config => node.name), :delayed
end

if node.sensu.firewall
  include_recipe "iptables"

  iptables_rule "port_sensu-api"
end

plugins = {
    "check-silenced.rb" => "https://raw.github.com/needle-cookbooks/sensu-community-plugins/needle/plugins/sensu/check-silenced.rb"
}

plugins.each do |name,src|
    sensu_plugin name do
      source src
      owner "sensu"
      group "sensu"
    end
end

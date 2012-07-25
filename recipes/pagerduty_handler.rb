sensu_gem 'redphone'

sensu_handler 'pagerduty.rb' do
  source 'https://raw.github.com/sensu/sensu-community-plugins/master/handlers/notification/pagerduty.rb'
  handler_config({"api_key" => ""})
  handler_settings({ "type" => "", "command" => "" })
end

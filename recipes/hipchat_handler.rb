sensu_gem "hipchat"

sensu_handler "hipchat.rb" do
  source "https://raw.github.com/sensu/sensu-community-plugins/master/handlers/notification/hipchat.rb"
  handler_config({ "apikey" => "", "room" => "" })
  handler_settings({ "type" => "", "command" => "" })
end
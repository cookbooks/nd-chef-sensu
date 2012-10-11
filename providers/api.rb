include Sensu::API

action :silence do
    Chef::Log.info("Silencing sensu notifications for #{instance_id}")
    api.silence_node(instance_id)
    new_resource.updated_by_last_action(true)
end

action :unsilence do
    Chef::Log.info("Unsilencing sensu notifications for #{instance_id}")
    api.unsilence_node(instance_id)
    new_resource.updated_by_last_action(true)
end

private
def api
    @@api ||= Sensu::API.new(@new_resource.sensu_api_url)
end

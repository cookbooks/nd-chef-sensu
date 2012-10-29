# installs a sensu handler in /etc/sensu/handlers

# sensu_handler "hipchat.sh" do
#   source "https://raw.github.com/sensu/sensu-community-plugins/master/handlers/notification/hipchat.rb"
#   handler_settings({ "type" => "pipe", "command" => "/etc/sensu/handlers/hipchat.rb" })
#   handler_config({ "apikey" => "1234abcdefg1234abcdefg", "room" => "Ops" })
# end

# sensu_handler "handler-from-mycookbook.rb" do
#   source "handler-from-mycookbook.rb.erb"
#   cookbook "mycookbook"
#   type :template
#   variables({"foo" => "bar"})
# end

# sensu_handler "handler-from-anothercookbook.rb" do
#   source "handler-from-anothercookbook.rb"
#   cookbook "anothercookbook"
#   type :file
# end

define :sensu_handler, :dir => "/etc/sensu/handlers/", :type => :remote, :source => false, :cookbook => false, :variables => false, :checksum => false, :action => :install, :owner => 'root', :group => 'root', :mode => "0755", :handler_config => {}, :handler_settings => {} do
  case params[:action]
  when :install
    case params[:type]
    when :template
      template ::File.join(params[:dir],params[:name]) do
        cookbook params[:cookbook] if params[:cookbook].is_a?(String)
        source params[:source]
        owner params[:owner]
        group params[:group]
        mode params[:mode]
        variables params[:variables] if params[:variables]
      end
    when :file
      cookbook_file ::File.join(params[:dir],params[:name]) do
        cookbook params[:cookbook] if params[:cookbook].is_a?(String)
        source params[:source]
        owner params[:owner]
        group params[:group]
        mode params[:mode]
      end
    when :remote
      remote_file ::File.join(params[:dir],params[:name]) do
        owner params[:owner]
        group params[:group]
        mode params[:mode]
        source params[:source]
        checksum params[:checksum] if params[:checksum]
        action :nothing
      end

      http_request "HEAD #{params[:name]}" do
        message ""
        url params[:source]
        action :head
        if File.exists?(::File.join(params[:dir],params[:name]))
          headers "If-Modified-Since" => File.mtime(::File.join(params[:dir],params[:name])).httpdate
        end
        notifies :create, resources(:remote_file => ::File.join(params[:dir],params[:name])), :immediately
      end
    end
  when :remove
    file ::File.join(params[:dir],params[:name]) do
      action :delete
    end
  end

  basename = ::File.basename(params[:name],File.extname(params[:name]))
  confd_path = ::File.expand_path(::File.join(params[:dir],'../conf.d'))
  handler_settings = { 'handlers' => { basename => params[:handler_settings] } }
  handler_config = { basename => params[:handler_config] }

  unless params[:action] == :delete
    json_file "/etc/sensu/conf.d/handler_#{basename}.json" do
      content handler_settings
      owner params[:owner]
      group params[:group]
      mode "0600"
    end

    unless params[:handler_config].empty?
      json_file "/etc/sensu/conf.d/#{basename}.json" do
        content handler_config
        owner params[:owner]
        group params[:group]
        mode "0600"
      end
    end
  end

end

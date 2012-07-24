# installs a sensu handler in /etc/sensu/handlers

# sensu_handler "hipchat.sh" do
#   source "https://raw.github.com/sensu/sensu-community-plugins/master/handlers/notification/hipchat.rb"
#   config({ "hipchat" => { "apikey" => "1234abcdefg1234abcdefg", "room" => "Ops"}})
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

define :sensu_handler, :dir => "/etc/sensu/handlers/", :type => :remote, :source => false, :cookbook => false, :variables => false, :checksum => false, :action => :install, :owner => 'root', :group => 'root', :mode => "0755", :config => {} do
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
        not_if {::File.exists?(::File.join(params[:dir],params[:name]))} unless params[:checksum]
      end
    end
  when :remove
    file ::File.join(params[:dir],params[:name]) do
      action :delete
    end
  end

  unless params[:config].empty? or params[:action] == :delete
    json_file ::File.join(params[:dir],::File.basename(params[:name])+".json") do
      contents params[:config]
      owner params[:owner]
      group params[:group]
      mode "0600" # we don't want to reuse the mode from the handler since it might allow other users to get our lucky charms
    end
  end

end
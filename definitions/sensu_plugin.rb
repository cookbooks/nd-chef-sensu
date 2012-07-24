# installs a sensu plugin in /etc/sensu/plugins

# sensu_plugin "check-mem.sh" do
#   source "https://raw.github.com/sensu/sensu-community-plugins/master/plugins/system/check-mem.sh"
# end

# sensu_plugin "check-from-mycookbook.rb" do
#   source "check-from-mycookbook.rb.erb"
#   cookbook "mycookbook"
#   type :template
#   variables({"foo" => "bar"})
# end

# sensu_plugin "check-from-anothercookbook.py" do
#   source "check-from-anothercookbook.py"
#   cookbook "anothercookbook"
#   type :file
# end

define :sensu_plugin, :dir => "/etc/sensu/plugins/", :type => :remote, :source => false, :cookbook => false, :variables => false, :checksum => false, :action => :install, :owner => 'root', :group => 'root', :mode => "0755" do
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
end
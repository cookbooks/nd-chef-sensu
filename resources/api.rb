actions :silence, :unsilence, :nothing

attribute :sensu_api_url, :kind_of => String

def initialize(*args)
  super
  @action = :nothing
end

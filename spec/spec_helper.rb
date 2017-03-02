$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'rake'
require 'webmoney'
require 'config'

require 'webmoney_files'

Config.load_and_set_settings(
  File.expand_path('../../config/settings.yml', __FILE__),
  File.expand_path('../../config/settings.local.yml', __FILE__)
)

class MyWM
  include Webmoney
end

RSpec.configure do |config|
  config.before :each, :webmoney do
    @webmoney ||= MyWM.new(
      wmid: Settings.keeper.wmid,
      password: Settings.keeper.password,
      key:  Settings.keeper.key,
      force_encoding: true)
  end
end

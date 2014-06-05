require 'pathname'
require 'virtus'

class TitechPubnetAuth
  class Config
    include Virtus::Model
    attribute :username, String
    attribute :password, String

    if RbConfig::CONFIG["target_os"].downcase =~ /^darwin/
      require 'keychain'
      SERVICE_NAME = 'titech-pubnet-auth'

      def self.get
        key = keychain_item
        key && new(username: key.account, password: key.password)
      end

      def self.keychain_item
        Keychain.generic_passwords.where(service: SERVICE_NAME).first
      end

      def save!
        key = self.class.keychain_item
        if key
          key.account = username
          key.password = password
          key.save!
        else
          Keychain.generic_passwords.create(service: SERVICE_NAME, account: username, password: password)
        end
        self
      end
    else
      require 'yaml'
      CONFIG_PATH = Pathname(__FILE__) + '../../../config/private.yml'

      def self.get
        new(YAML.load_file(CONFIG_PATH)) rescue nil
      end

      def save!
        CONFIG_PATH.open('w') do |f|
          f << attributes.to_yaml
        end
        self
      end
    end
  end
end

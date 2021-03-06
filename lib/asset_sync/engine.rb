class Engine < Rails::Engine

  engine_name "asset_sync"

  initializer "asset_sync config", :group => :all do |app|
    app_initializer = File.join(Rails.root, 'config/initializers/asset_sync.rb')
    app_yaml = File.join(Rails.root, 'config/asset_sync.yml')

    if File.exists?( app_initializer )
      # STDERR.puts "AssetSync: using #{app_initializer}"
      load app_initializer
    else
      # STDERR.puts "AssetSync: using default configuration from built-in initializer"
      AssetSync.configure do |config|
        config.aws_access_key = ENV['AWS_ACCESS_KEY']
        config.aws_access_secret = ENV['AWS_ACCESS_SECRET']
        config.aws_bucket = ENV['AWS_BUCKET']
        config.existing_remote_files = "keep"
      end unless File.exists?( app_yaml )
    end

    # if File.exists?( app_yaml )
    # STDERR.puts "AssetSync: YAML file found #{app_yaml} settings will be merged into the configuration"
    # end
  end

end

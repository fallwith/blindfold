class Launcher
  SPEC_OPTS_FILE  = 'spec.opts'
  BLUEPRINTS_DIR  = 'blueprints'  # lives within config_dir
  MATCHERS_DIR    = 'matchers'    # lives within config_dir
  HELPERS_DIR     = 'helpers'     # lives within config_dir

  def initialize(args={})
    Blindfold.config_dir = args[:config_dir] if args.has_key?(:config_dir)
    Blindfold.rails_root = args[:rails_root] if args.has_key?(:rails_root)
    Blindfold.boot_redis = args[:boot_redis] if args.has_key?(:boot_redis)
  end
  
  def run(arguments)
    start_redis if Blindfold.boot_redis
    init_rails if Blindfold.rails_root
    init_helpers
    init_blueprints
    init_matchers
    run_spec(arguments)
    stop_redis if Blindfold.boot_redis
  end
  
  private

  def init_helpers
    helpers_dir = File.join(Blindfold.config_dir, HELPERS_DIR)
    if Dir.exists?(helpers_dir)
      # Dir[File.join(helpers_dir,'**','*.rb')].each {|f| load f}
      Dir[File.join(helpers_dir,'**','*.rb')].each {|f| warn "LOADING #{f}..."; load f}
    end
  end

  def init_blueprints
    # Introduce all helper methods to Machinist
    Machinist::Lathe.send :include, HelperMethods
    # Load up all blueprints
    blueprints_dir = File.join(Blindfold.config_dir, BLUEPRINTS_DIR)
    if Dir.exists?(blueprints_dir)
      Dir[File.join(blueprints_dir,'**','*_blueprint.rb')].each {|f| load f}
    end
  end
  
  def init_matchers
    matchers_dir = File.join(Blindfold.config_dir, MATCHERS_DIR)
    if Dir.exists?(matchers_dir)
      Dir[File.join(matchers_dir,'**','*.rb')].each {|f| load f}
    end
  end

  # Light up Spec::Runner
  def run_spec(args)
    # Introduce Rack::Test to RSpec
    Spec::Runner.configure do |config|
      config.include Rack::Test::Methods
    end

    # Introduce all helper methods to RSpec
    Spec::Runner.configuration.include(HelperMethods)

    # Specify which spec.opts file to use
    spec_opts = File.join(Blindfold.config_dir, SPEC_OPTS_FILE)
    if File.exists?(spec_opts)
      args << '-O' << spec_opts
    end

    ::Spec::Runner::CommandLine.run(::Spec::Runner::OptionParser.parse(args, STDERR, STDOUT))
  end
  
  def init_rails
    require File.join(Blindfold.rails_root, 'config', 'environment') if Blindfold.rails_root
  end
  
  def redis_pid
    `ps acx|grep redis-server|awk {'print $1'}`.chomp
  end

  # Start redis if necessary and requested
  def start_redis
    return if RUBY_PLATFORM =~ /mswin|mingw/
    if redis_pid == ''
      redis_binary = `which redis-server`.chomp
      if redis_binary.chomp != ''
        spawn "echo 'daemonize yes'|#{redis_binary} -"
        puts "Started redis-server [#{redis_pid}]"
        @started_redis = true
      end
    end
  end

  # Stop redis if this class started it earlier
  def stop_redis
    return unless @started_redis
    return if RUBY_PLATFORM =~ /mswin|mingw/
    print 'Stopping redis-server...'
    `killall redis-server`
    puts 'Done'
  end
end
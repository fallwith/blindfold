module HelperMethods
  # Spawn n blueprint driven instances of a model
  # NOTE: Machinist2 makes this easy enough to do with 'make' itself
  def spawn(name, args={})
    
    # Reload Machinist blueprints despite them having been loaded earlier.
    # For some reason, Rack::Test's use of ActionController::Dispatcher.call(env)
    # causes the blueprints to fall out of scope for the next Connection instance.
    #
    # TODO: determine root cause, raise ticket if necessary with Rack::Test
    #
    blueprints_dir = File.join(Blindfold.config_dir, Launcher.blueprints_dir)
    if Dir.exists?(blueprints_dir)
      Dir[File.join(blueprints_dir,'**','*_blueprint.rb')].each {|f| load f}
    end
    
    klass = name.to_s.singularize.camelize.constantize
    # klass.make(args)
    OpenStruct.new(klass.make(args).attributes)
  end
end
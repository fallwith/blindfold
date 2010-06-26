module HelperMethods
  # Spawn n blueprint driven instances of a model
  # NOTE: Machinist2 makes this easy enough to do with 'make' itself
  def spawn(name, args={})
    klass = name.to_s.singularize.camelize.constantize
    # klass.make(args)
    OpenStruct.new(klass.make(args).attributes)
  end
end
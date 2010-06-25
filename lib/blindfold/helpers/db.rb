module HelperMethods
  def wipe(name)
    klass = name.to_s.singularize.camelize.constantize
    klass.delete_all
  end

  def spawn(name, args={})
    klass = name.to_s.singularize.camelize.constantize
    klass.make(args)
  end
end
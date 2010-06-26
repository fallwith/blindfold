module HelperMethods
  # Wipe a database table completely or based on an array of ids
  def wipe(name, ids=[])
    ids = Array(ids) # allow a single id to be passed in
    klass = name.to_s.singularize.camelize.constantize
    ids.empty? ? klass.delete_all : klass.delete_all(['id IN (?)', ids])
  end
end
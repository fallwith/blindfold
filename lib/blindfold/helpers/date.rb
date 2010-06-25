module HelperMethods
  # Inspired by random_data's date method, http://github.com/tomharris/random_data
  def random_datetime(args={:dayrange => 7, :force_future => false})
    offset = args[:force_future] ? rand(args[:dayrange]) : (rand(args[:dayrange]*2)-args[:dayrange])
    Time.now + (offset * 24 * 60 * 60)
  end
end
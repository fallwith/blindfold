module HelperMethods
  def random_string(length=12)
    Forgery::Basic.text(:at_least => length, :at_most => length)
  end
end
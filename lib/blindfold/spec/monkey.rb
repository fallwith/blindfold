module Spec::Example::ExampleGroupMethods
  alias scenario example   # Steak
  alias background before  # Steak
  def prepare(&block)
    before :all, &block
  end
  def cleanup(&block)
    after :all, &block
  end
end

module Spec::DSL::Main
  alias feature describe   # Steak
end
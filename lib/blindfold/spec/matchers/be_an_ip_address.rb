Spec::Matchers.define :be_an_ip_address do
  match do |ip_address|
    ip_address.to_s =~ /^(?:(?:\d+\.){3}|(?:\d+\.){5})\d+$/
  end
  failure_message_for_should do |ip_address|
    "expected '#{ip_address}' to be a valid IP Address format (v4 or v6)"
  end
  failure_message_for_should_not do |ip_address|
    "expected '#{ip_address}' to not be a valid IP Address format (v4 or v6)"
  end
  description do
    "expected an IP Address to be in a valid format (v4 or v6)"
  end
end
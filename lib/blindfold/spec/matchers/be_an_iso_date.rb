Spec::Matchers.define :be_an_iso_date do
  pattern = /^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}[-+]\d{2}:\d{2}$/
  match do |date|
    date.to_s =~ pattern
  end
  failure_message_for_should do |date|
    "expected '#{date}' to be an ISO 8601 formatted date string (#{pattern})"
  end
  failure_message_for_should_not do |date|
    "expected '#{date}' to not be in ISO 8601 format (#{pattern})"
  end
  description do
    "expected a date string to be in ISO 8601 format"
  end
end
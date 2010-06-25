module Spec
  module Matchers
    # This drills down into the .status and .result objects of
    # response to see whether they both have successful states.
    # This is needed because a param validation error may throw
    # 200 Ok but -5 Invalid param (by design)
    def be_ok
      Matcher.new :be_ok do
        match do |response|
          status_element = Nokogiri::XML(response.body).xpath('/result/status').first
          status_id = status_element ? status_element.xpath('id').first.text : nil
          response.status == 200 && status_id == '0'
        end

        failure_message_for_should do |response|
          status_element = Nokogiri::XML(response.body).xpath('/result/status').first
          if status_element
            status_id = status_element.xpath('id').first.text
            status_message = status_element.xpath('message').first.text
            text = "#{status_id}: #{status_message}"
          else
            text = response.body
          end
          <<-MESSAGE
expected HTTP 200 / 0: Successful Completion
     got HTTP #{response.status} / #{text}
MESSAGE
        end

        failure_message_for_should_not do |response|
          status_element = Nokogiri::XML(response.body).xpath('/result/status').first
          if status_element
            status_id = status_element.xpath('id').first.text
            status_message = status_element.xpath('message').first.text
            text = "#{status_id}: #{status_message}"
          else
            text = response.body
          end
          <<-MESSAGE
expected not HTTP 200 / 0: Successful Completion
     got HTTP #{response.status} / #{text}
MESSAGE
        end
      end
    end
  end
end
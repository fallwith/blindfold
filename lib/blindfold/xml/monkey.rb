module Nokogiri::XML
  class Document
    def elements(name)
      xpath("//#{name}")
    end
    def element(name)
      elements(name).first
    end
  end
  class Element
    def attribute_value(name)
      attribute(name).value
    end
  end
  class NodeSet
    def with_attributes(attributes)
      # TODO: refactor to remove eval
      conditions = attributes.collect{|k,v| "e['#{k.to_s}'] == '#{v.to_s}'"}.join(' && ')
      eval "select{|e| #{conditions}}"
    end
  end
end
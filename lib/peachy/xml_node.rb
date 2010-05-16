module Peachy
  module XmlNode
    private
    # Runs the XPath for the method name against the underlying XML DOM,
    # returning nil if no element or attribute matching the method name is found
    # in the children of the current location in the DOM.
    def find_matches method_name
      matches = node.xpath(xpath_for(method_name))
      return nil if matches.length < 1
      return matches
    end

    def find_match_by_attributes method_name
      mapped = method_name.variations.map {|variation| node.attribute(variation) }
      mapped.find {|match| match != nil }
    end

    def find_attribute method_name
      node.attribute(method_name.to_s)
    end

    def has_children_and_attributes?
      there_are_child_nodes? and node_has_attributes?
    end

    # Determines whether the given element contains any child elements or not.
    # The choice of implementation is based on performance tests between using
    # XPath and a Ruby iterator.
    def there_are_child_nodes?
      #node.children.any? {|child| child.kind_of? Nokogiri::XML::Element }
      node.children.any? {|child| child.kind_of? Peachy::Parsers::NokogiriWrapper }
    end

    def node_has_attributes?
      node.attribute_nodes.size > 0
    end

    # Gets the XPath for all variations of the MethodName instance
    def xpath_for method_name
      method_name.variations.map {|variation| "./#{variation}" } * '|'
    end

    def clone
      ProxyFactory.create_from_element(node)
    end

    # Returns the name of the encapsulated node.
    def node_name
      node.name
    end

    # The encapsulated Nokogiri node, which is lazy loaded from the @xml instance
    # variable.
    def node
      raise InvalidProxyParameters.new(:xml => nil, :nokogiri => nil) if variables_are_nil?
      @nokogiri_node ||= Peachy::Parsers::NokogiriWrapper.new(Nokogiri::XML(@xml))
    end
  end
end

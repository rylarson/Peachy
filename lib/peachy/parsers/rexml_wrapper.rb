module Peachy
  module Parsers
    class REXMLWrapper < ParserWrapper
      [:name, :to_s].each{|method| define_method(method) { @rexml.send(method) }}

      def initialize rexml_element
        @rexml = rexml_element
      end

      def find_matches method_name
        matches = REXML::XPath.match(@rexml, method_name.as_xpath)
        return nil if matches.size < 1
        matches.map {|node| REXMLWrapper.new(node)}
      end

      def find_match_by_attributes method_name
        match = @rexml.attributes.find {|attribute| method_name.variations.include? attribute.first }
        match.nil? ? nil : REXMLAttributeWrapper.new(match)
      end

      def has_children_and_attributes?
        has_children? and has_attributes?
      end

      def content
        @rexml.text
      end

      private
      def has_children?
        @rexml.elements.size > 0
      end

      def has_attributes?
        @rexml.attributes.size > 0
      end
    end
  end
end
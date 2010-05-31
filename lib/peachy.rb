require 'rubygems'

require File.join(File.dirname(__FILE__), 'already_an_only_child')
require File.join(File.dirname(__FILE__), 'invalid_proxy_parameters')
require File.join(File.dirname(__FILE__), 'method_not_in_ruby_convention')
require File.join(File.dirname(__FILE__), 'no_matching_xml_part')
require File.join(File.dirname(__FILE__), 'peachy/string_styler')
require File.join(File.dirname(__FILE__), 'peachy/method_name')
require File.join(File.dirname(__FILE__), 'peachy/method_mask')
require File.join(File.dirname(__FILE__), 'peachy/mimic')
require File.join(File.dirname(__FILE__), 'peachy/morph_into_array')
require File.join(File.dirname(__FILE__), 'peachy/my_meta_class')
require File.join(File.dirname(__FILE__), 'peachy/xml_node')
require File.join(File.dirname(__FILE__), 'peachy/simple_content')
require File.join(File.dirname(__FILE__), 'peachy/parsers/parser_factory')
require File.join(File.dirname(__FILE__), 'peachy/parsers/with_xpath')
require File.join(File.dirname(__FILE__), 'peachy/parsers/parser_wrapper')
require File.join(File.dirname(__FILE__), 'peachy/parsers/nokogiri_wrapper')
require File.join(File.dirname(__FILE__), 'peachy/parsers/rexml_wrapper')
require File.join(File.dirname(__FILE__), 'peachy/parsers/rexml_attribute_wrapper')
require File.join(File.dirname(__FILE__), 'peachy/proxy')
require File.join(File.dirname(__FILE__), 'peachy/proxy_factory')
require File.join(File.dirname(__FILE__), 'peachy/childless_proxy_with_attributes')

module Peachy
  def self.whine
    @whine = true
  end

  def self.whiny?
    return @whine
  end

  def self.proxy xml
    create_factory unless defined? @factory
    return Proxy.new(@factory.make_from(xml))
  end

  private
  def self.create_factory
    @factory ||= Peachy::Parsers::ParserFactory.new
    @factory.load_parser
    return @factory
  end
end
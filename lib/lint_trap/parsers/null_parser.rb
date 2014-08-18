require_relative 'base_parser'

module LintTrap
  module Parsers
    # Handles parsing for unknown linters
    class NullParser < BaseParser
      def parse
      end
    end
  end
end

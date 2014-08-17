module LintTrap
  module Parsers
    # Handles parsing LintCI standard format
    class StandardParser < BaseParser
      VIOLATION_FIELDS = %w(file line column length rule severity message)
      VIOLATION_REGEX = /
        (?<file>[^:]+):
        (?<line>[^:]*):
        (?<column>[^:]*):
        (?<length>[^:]*):
        (?<rule>[^:]*):
        (?<severity>[^:]*):
        (?<message>.+)
      /x

      def parse
        @io.each_line do |line|
          next unless (violation = parse_line(line))

          yield violation
        end
      end

    private

      def parse_line(line)
        return unless (match = line.match(VIOLATION_REGEX))

        VIOLATION_FIELDS.each_with_object({}) do |field, violation|
          violation[field.to_sym] = match[field].empty? ? nil : match[field]
        end
      end
    end
  end
end

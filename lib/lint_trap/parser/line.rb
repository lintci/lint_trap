require_relative 'base'

module LintTrap
  module Parser
    # Handles parsing line by line with regex
    class Line < Base
      def parse
        io.each_line do |line|
          puts line
          next unless (violation = parse_line(line))

          yield violation
        end
      end

    private

      def parse_line(line)
        return unless (match = line.match(violation_regex))

        violation = violation_fields.each_with_object({}) do |field, violation|
          violation[field.to_sym] = if match.names.include?(field) && !match[field].empty?
            match[field]
          else
            nil
          end
        end

        standardize(violation)
      end

      def violation_fields
        %w(file line column length rule severity message)
      end

      def violation_regex
        raise NotImplementedError, "Subclass #{self.class.name} must implement violation_regex."
      end

      def standardize(violation)
        violation[:file] = container.local_path(violation[:file])

        violation
      end
    end
  end
end

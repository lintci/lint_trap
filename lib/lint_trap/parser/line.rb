require_relative 'base'

module LintTrap
  module Parser
    # Handles parsing line by line with regex
    class Line < Base
      def parse(io, container)
        output = ''

        io.each_line do |line|
          if (violation = parse_line(line, container))
            yield violation
          else
            output << line
          end
        end

        output
      end

    private

      def parse_line(line, container)
        return unless (match = line.match(violation_regex))

        violation = {}
        violation_fields.each do |field|
          violation[field.to_sym] = if match.names.include?(field) && !match[field].empty?
            match[field]
          else
            nil
          end
        end

        standardize(violation, container)
      end

      def violation_fields
        %w(file line column length rule severity message)
      end

      def violation_regex
        raise NotImplementedError, 'Must implement violation_regex.'
      end

      def standardize(violation, container)
        violation[:file] = container.local_path(violation[:file])

        violation
      end
    end
  end
end

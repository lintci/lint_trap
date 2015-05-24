module LintTrap
  # Error thrown from code that executes an external command.
  class ExecutionError < StandardError
    attr_reader :command, :output

    def initialize(command, output)
      super("An error occurred while running `#{command}`. The output was:\n#{output}")
      @command = command
      @output = output
    end
  end
end

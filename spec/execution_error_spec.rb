require 'spec_helper'

describe LintTrap::ExecutionError do
  let(:command){'ls'}
  let(:output){"Ain't got no time for that"}
  subject(:error){described_class.new(command, output)}

  its(:message){is_expected.to eq("An error occurred while running `#{command}`. The output was:\n#{output}")}
  its(:command){is_expected.to eq(command)}
  its(:output){is_expected.to eq(output)}
end

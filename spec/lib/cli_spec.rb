require "spec_helper"

describe Jbssh::CLI do
  it "has a version number" do
    expect(Jbssh::VERSION).not_to be nil
  end
end
RSpec.describe 'CLI Test', :type => :aruba do
  # let(:file) { 'db/jbssh.db' }
  # let(:content) { 'Hello World' }
  #
  # before(:each) { write_file file, content }
  # it { expect(read(file)).to eq [content] }

  # let(:version) { 'version'}
  # let(:ARGV) { [] }
  # before(:each) do
  #   ARGV << version
  # end

  before(:each) { run_simple 'echo running' }
  it { expect(last_command_started.stdout.chomp).to eq 'running' }

  it "has version info"do
    run_simple 'jbssh version'
    version = Jbssh::VERSION
    expect(last_command_started.stdout.chomp.match(/Version: #{version}/)[0]).to eq "Version: #{version}"
  end
end

require 'spec_helper'
describe 'bgp_spamd' do

  context 'with defaults for all parameters' do
    it { should contain_class('bgp_spamd') }
  end
end

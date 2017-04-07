require 'spec_helper'

describe 'bgp_spamd' do

  context 'with default parameter' do
    it { is_expected.to compile.with_all_deps }  # same as above except it will test all the dependencies
    it { is_expected.to contain_class('bgp_spamd::config') }
    it { is_expected.to contain_class('bgp_spamd::spamtraps') }
    it { is_expected.to contain_class('bgp_spamd::service') }
  end

end

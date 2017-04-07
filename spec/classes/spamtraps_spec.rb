require 'spec_helper'

describe 'bgp_spamd::spamtraps' do

  context 'with spamtraps parameter set to empty array []' do
    let (:params) { {
      :spamtraps => [],
    } }
    it { is_expected.to compile.with_all_deps }  # test all the dependencies
    it { is_expected.not_to contain_exec(/spamtrap .*/) }
  end
  context 'with spamtraps parameter set to single string' do
    let (:params) { {
      :spamtraps => 'yalla@blah.com',
    } }
    it { is_expected.not_to compile.with_all_deps }  # test all the dependencies
  end
  context 'with spamtraps parameter set to single element array' do
    let (:params) { {
      :spamtraps => [ 'ex@ample.com' ],
    } }
    it { is_expected.to compile.with_all_deps }  # test all the dependencies
    it { is_expected.to contain_exec('spamtrap ex@ample.com') }
  end
  context 'with spamtraps parameter containing double entries' do
    let (:params) { {
      :spamtraps => [ 'ex@ample.com', 'ex@ample.com' ],
    } }
    it { is_expected.to compile.with_all_deps }  # test all the dependencies
    it { is_expected.to contain_exec('spamtrap ex@ample.com') }
  end
  context 'with spamtraps parameter containing double entries with different case' do
    let (:params) { {
      :spamtraps => [ 'ex@ample.com', 'EX@AMPLE.COM' ],
    } }
    it { is_expected.to compile.with_all_deps }  # test all the dependencies
    it { is_expected.to contain_exec('spamtrap ex@ample.com') }
  end

end

require 'spec_helper'

describe 'bgp_spamd' do

  it { is_expected.to compile.with_all_deps }  # same as above except it will test all the dependencies

end

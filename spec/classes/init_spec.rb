require 'spec_helper'
describe 'al_kcare' do
  context 'with default values for all parameters' do
    it { should contain_class('al_kcare') }
  end
end

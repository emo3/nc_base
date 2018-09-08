#
# Cookbook:: nc_base
# Spec:: default
#
# Copyright:: 2018, Ed Overton, All Rights Reserved.

require 'spec_helper'

describe 'nc_base::make_nc_base' do
  context 'When all attributes are default, on an RedHat 7.5' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'redhat', version: '7.5')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end

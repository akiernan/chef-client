#
# Author:: Alex Kiernan <alexk@alexandalex.com>
# Copyright:: Copyright (c) 2013, Opscode, Inc. <legal@opscode.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

$:.unshift(File.join(File.dirname(__FILE__), '..'))
require 'spec_helper'

describe Opscode::ChefClient::Helpers do
  include ::Opscode::ChefClient::Helpers

  let(:node) do
    {
      'chef_client' => {
        'config' => {
          'no_proxy' => nil
        }
      }
    }
  end

  describe '#no_proxy_as_env_var' do
    it 'should handle nil correctly' do
      expect(no_proxy_as_env_var).to be_nil
    end
  end

  context 'single wildcard' do
    before do
      node['chef_client']['config']['no_proxy'] = '*'
    end

    it 'handles no_proxy for all domains' do
      expected = '*'
      expect(no_proxy_as_env_var).to eq(expected)
    end
  end

  context 'all options' do
    before do
      node['chef_client']['config']['no_proxy'] = '*.localdomain,localhost,*.localdomain:8080,localhost.localdomain'
    end

    it 'handles multiple domains with wildcards and port specifications' do
      expected = '.localdomain,localhost,.localdomain:8080,localhost.localdomain'
      expect(no_proxy_as_env_var).to eq(expected)
    end
  end
end

#
# Author:: Alex Kiernan (<alexk@alexandalex.com>)
# Cookbook Name:: chef-client_test
# Recipe:: cook-3196
#
# Copyright 2013, Alex Kiernan
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require File.expand_path('../support/helpers', __FILE__)

describe 'chef-client::config' do
  include Helpers::ChefClient

  it 'contains the https_proxy and no_proxy environment settings' do
    file(File.join(node['chef_client']['conf_dir'], 'client.rb')).must_match('^ENV\[\'https_proxy\'\]')
    file(File.join(node['chef_client']['conf_dir'], 'client.rb')).must_match('^ENV\[\'HTTPS_PROXY\'\]')
    file(File.join(node['chef_client']['conf_dir'], 'client.rb')).must_match('^ENV\[\'no_proxy\'\]')
    file(File.join(node['chef_client']['conf_dir'], 'client.rb')).must_match('^ENV\[\'NO_PROXY\'\]')
  end
end

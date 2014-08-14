#
# Cookbook Name:: mercurial
# Recipe:: package
#
# Copyright 2009, Opscode, Inc.
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

case node['platform']
when "windows"
  windows_package "Mercurial" do
    source node['hg']['windows_url']
    action :install
  end
else
  include_recipe 'yum-repoforge' if platform_family?('rhel') && node['hg']['use_repoforge']

  package "mercurial" do
    options '-y --enablerepo=rpmforge-extras' if platform_family?('rhel') && node['hg']['use_repoforge']
    action :upgrade
  end
end

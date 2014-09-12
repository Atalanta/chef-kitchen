#
# Cookbook Name:: kitchen
# Recipe:: default
#
# Copyright (c) 2014 The Authors, All Rights Reserved.

include_recipe 'virtualbox'

include_recipe 'vagrant'

package 'git'

user 'kitchen' do
  supports :manage_home => true
  shell '/bin/bash'
end

directory '/home/kitchen' do
  owner 'kitchen'
end



case node['platform_family'] 

when 'debian'
  package_name = "chefdk_#{node['chefdk']['version']}_amd64.deb"
  package_source = File.join(node['chefdk']['base_url'], 'ubuntu/12.04/x86_64', package_name)
  
  remote_file "#{Chef::Config[:file_cache_path]}/chefdk.deb" do
    source package_source
    notifies :install, 'dpkg_package[chefdk]', :immediately
  end
  
  dpkg_package 'chefdk' do
    source "#{Chef::Config[:file_cache_path]}/chefdk.deb"
  end
  
when 'rhel'
  package_name = "chefdk-#{node['chefdk']['version']}.el6.x86_64.rpm"
  package_source = File.join(node['chefdk']['base_url'], 'el/6/x86_64', package_name)

  remote_file "#{Chef::Config[:file_cache_path]}/chefdk.rpm" do
    source package_source
    notifies :install, 'rpm_package[chefdk]', :immediately
  end
  
  rpm_package 'chefdk' do
    source "#{Chef::Config[:file_cache_path]}/chefdk.rpm"
  end
  
end

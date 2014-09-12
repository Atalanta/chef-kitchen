require 'spec_helper'

describe 'Kitchen Cookbook Default Recipe' do
  
  it 'should create a kitchen user' do
    expect(user('kitchen')).to exist
    expect(user('kitchen')).to have_home_directory '/home/kitchen'
    expect(user('kitchen')).to have_login_shell '/bin/bash'
  end

  it 'should have a home directory' do
    expect(file('/home/kitchen')).to be_directory
    expect(file('/home/kitchen')).to be_owned_by 'kitchen'
  end

  it 'should install virtualbox' do
    expect(command('VBoxManage --version')).to return_stdout /\d+\.\d+\.\d+r\d+$/
  end

  it 'should install Vagrant' do
    expect(command('vagrant --version')).to return_stdout /Vagrant \d+\.\d+\.\d+$/
  end

  it 'should install the ChefDK' do
    expect(command 'chef --version').to return_stdout /Chef Development Kit Version: \d+\.\d+\.\d+$/
  end

  it 'should install git' do
    expect(command 'git --version').to return_stdout /git version \d+\.\d+\.\d+$/
  end
  
end



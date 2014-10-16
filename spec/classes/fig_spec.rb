require "spec_helper"

describe "fig" do
  let(:test_params) { {
    :ensure     => "present",
    :executable => "/test/boxen/bin/fig",
    :user       => "testuser",
    :version    => "1.0.0",
  } }

  let(:facts) { default_test_facts }
  let(:params) { test_params }

  context "ensure => present" do
    it do
      should contain_exec("install-fig").with({
        :command => "curl -L https://github.com/docker/fig/releases/download/1.0.0/fig-Darwin-x86_64 > /test/boxen/bin/fig",
        :user    => "testuser",
        :unless  => "test -x /test/boxen/bin/fig && /test/boxen/bin/fig --version | grep '\\b1.0.0\\b'",
      })

      should contain_exec("fix-fig-permissions").with({
        :command => "chmod a+x /test/boxen/bin/fig",
        :user    => "testuser",
      })
    end
  end

  context "ensure => absent" do
    let(:params) { test_params.merge(:ensure => "absent") }

    it do
      should contain_file("/test/boxen/bin/fig").with_ensure("absent")
    end
  end

  context "ensure => whatever" do
    let(:params) { test_params.merge(:ensure => "whatever") }

    it do
      expect { should compile }.to raise_error(Puppet::Error, /validate_re.*?does not match/)
    end
  end

  context "hardwaremodel => whatever" do
    let(:facts) { default_test_facts.merge(:hardwaremodel => "whatever") }

    it do
      expect { should compile }.to raise_error(Puppet::Error, /validate_re.*?does not match/)
    end
  end

  context "kernel => whatever" do
    let(:facts) { default_test_facts.merge(:kernel => "whatever") }

    it do
      expect { should compile }.to raise_error(Puppet::Error, /validate_re.*?does not match/)
    end
  end
end

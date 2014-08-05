require "spec_helper"

describe "fig" do
  let(:default_params) do
    {
      :ensure     => "present",
      :executable => "/test/boxen/bin/fig",
      :version    => "0.9.9"
    }
  end

  let(:facts) { default_test_facts }
  let(:params) { default_params }

  context "ensure => present, kernel => darwin" do
    it do
      should contain_exec("install-fig").with({
        :command => "curl -L https://github.com/orchardup/fig/releases/download/0.9.9/darwin > /test/boxen/bin/fig",
        :user    => "testuser",
        :unless  => "test -x /test/boxen/bin/fig && /test/boxen/bin/fig --version | grep '\\b0.9.9\\b'",
      })
    end
  end

  context "ensure => present, kernel => linux" do
    let(:facts) { default_test_facts.merge(:kernel => "Linux") }

    it do
      should contain_exec("install-fig").with({
        :command => "curl -L https://github.com/orchardup/fig/releases/download/0.9.9/linux > /test/boxen/bin/fig",
        :user    => "testuser",
        :unless  => "test -x /test/boxen/bin/fig && /test/boxen/bin/fig --version | grep '\\b0.9.9\\b'",
      })
    end
  end

  context "ensure => absent" do
    let(:params) { default_params.merge(:ensure => "absent") }

    it do
      should contain_file("/test/boxen/bin/fig").with_ensure("absent")
    end
  end

  context "ensure => whatever" do
    let(:params) { default_params.merge(:ensure => "whatever") }

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

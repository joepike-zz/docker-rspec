require 'serverspec'
require 'docker'

describe "Dockerfile" do

  before(:all) do
    @image = Docker::Image.build_from_dir('.')
    @container = Docker::Container.create('container')

    set :os, family: :debian
    set :backend, :docker
    set :docker_image, @image.id
  end

  it "should exist" do
    expect(@image).to_not be_nil
  end

  it "installs required packages" do
    expect(package("nodejs")).to be_installed
  end

  def os_version
    command("lsb_release -a").stdout
  end

end

describe port(80) do
  it { should be_listening }
end

require 'spec_helper'

describe port(8153) do
  it { should be_listening }
end

describe service('go-server') do
  it { should be_enabled }
  it { should be_running }
end

describe service ('go-agent') do
  it { should be_enabled }
  it { should be_running }
end

describe server(:server) do
  describe http('http://localhost:8153') do
    xit "responds with the GoCD login page" do
      expect(response.body).to inlcude ('GoCD') #this totally isn't right, but will fix later
    end
  end
end

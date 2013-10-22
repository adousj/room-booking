# encoding: utf-8

require 'spec_helper'

describe "App" do

  before :each do
    get '/'
  end

  it "should redirect to /day/:today" do
    # today = Time.now.to_date
    expect(last_response.status).to eq(302)
    # expect(last_response).to redirect_to("/day/#{today}")
  end

end

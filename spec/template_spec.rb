
require 'spec_helper'
require 'rails_helper'
require "common-template"

require "byebug"

ENV["RAILS_ENV"] ||= "test"
require File.expand_path("spec/support/dummy_app/config/environment.rb")


describe StaticPagesController, type: :controller do
  it 'should work' do
    get :home
    expect(response).to render_template(:home)
  end
end


describe StaticPagesController, type: :controller do
  it 'should work' do
    StaticPagesController.send(:common_template, "common")
    get :home
    expect(response).to render_template(:common)
  end
end


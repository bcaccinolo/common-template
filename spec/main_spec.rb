require "action_controller"
require "common-template"
require 'simple_controller'
require 'spec_helper'
require "byebug"

RSpec.describe "a simple configuration" do
  it "should work" do
    SimpleController.send(:common_template, "common")
    expect(SimpleController.template).to eq "common"
    expect(SimpleController.common_actions).to eq []
  end
end

RSpec.describe "an advanced configuration" do
  it "should work" do
    SimpleController.send(:common_template, "common", {just:[:home]})
    expect(SimpleController.template).to eq "common"
    expect(SimpleController.common_actions).to eq [:home]
  end
end

RSpec.describe "#relevant_for" do
  it "should work" do
    SimpleController.send(:common_template, "common")
    controller = SimpleController.new
    expect(controller.relevant_for(:home)).to eq true
    expect(controller.relevant_for("home")).to eq true
    expect(controller.relevant_for(:about)).to eq true
    expect(controller.relevant_for("about")).to eq true
  end

  it "should work" do
    SimpleController.send(:common_template, "common", {just:[:home]})
    controller = SimpleController.new
    expect(controller.relevant_for(:home)).to eq true
    expect(controller.relevant_for(:about)).to eq false
  end
end






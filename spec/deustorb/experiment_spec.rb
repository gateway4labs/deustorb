require 'spec_helper'

module Deustorb
  describe Experiment do
    describe ".new_from_identifier" do
      it "returns a new experiment with correct name and category name" do
        exp = Experiment.new_from_identifier('robot-movement@robots')
        expect(exp.name).to eql('robot-movement')
        expect(exp.category_name).to eql('robots')
      end
    end

    it "takes an attributes hash" do
      exp = Experiment.new(name: 'robot-movement', category_name: 'robots')
      expect(exp.name).to eql('robot-movement')
      expect(exp.category_name).to eql('robots')
    end

    it "takes a block that yields himself" do
      exp = Experiment.new do |exp|
        exp.time_allowed = 3
      end
      expect(exp.time_allowed).to eql(3)
    end
  end
end
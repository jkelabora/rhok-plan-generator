require 'spec_helper'

describe PlansHelper do
  describe "#table_header_values" do
    it "should have 'Items to include' when event name is Relocation Kit" do
      expect(helper.table_header_values("Relocation Kit")).to eq([["Assignee(s)", "Items to include", "Done?"]])
    end
  end

end
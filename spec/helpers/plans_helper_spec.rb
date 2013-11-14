require 'spec_helper'

describe PlansHelper do
  describe "#table_header_values" do
    it "should have 'Items to include' when event name is Relocation Kit" do
      expect(helper.table_header_values("Relocation Kit")).to eq([["Allocated to", "Items to include", "Done?"]])
    end

    it "should have 'Items to include' when event name is Emergency Kit" do
      expect(helper.table_header_values("Emergency Kit")).to eq([["Allocated to", "Items to include", "Done?"]])
    end

    it "should not have 'Items to include' when event name is Emergency Contact Numbers" do
      expect(helper.table_header_values("Emergency Contact Number")).not_to eq([["Allocated to", "Items to include", "Done?"]])
    end

  end

end
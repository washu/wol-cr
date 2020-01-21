require "./spec_helper"
describe Wol do
  it "works" do
	resolved = "no ip"
	Wol.wake("48:8D:36:76:54:A0",resolver: ->(i : String) {
		resolved = i
	})
	resolved.should eq("no ip")
	Wol.wake("48:8D:36:76:54:A2",port: 7,num_packets: 3).should eq(true)
  end
end

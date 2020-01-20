require "./spec_helper"
describe Wol do
  it "works" do
	Wol.wake("48:8D:36:76:54:A2") {|x|     
		x.should eq(true)
	}
	Wol.wake("48:8D:36:76:54:A2",{"num_packets" => 3, "port"=> 7}){|x|
		x.should eq(true)
	}
  end
end

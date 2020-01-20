# Create an interface to the Wake on Lan feature of most nics
require "socket"

module Wol
  extend self
  VERSION = "0.1.0"
  # Options:
  #		address: String target address defaults to 255.255.255.255
  #		num_packets: Int32 number of packets to send (defauls to 3)
  #		interval: Int32 number of milliseconds between sends
  #		port: Int32 port to send message, defaults to 9 (7 could be a viable alternative)
  #		secure: password to generate a secure wol packet
  # accepts a block
  def wake(mac_address : String, opts : Hash(String,String | Int32 ) = {"address" => "255.255.255.255","num_packets"=>3,"interval"=>100,"port"=>9,"secure"=>""})
		address = opts["address"]? || "255.255.255.255"
		num_packets = (opts["num_packets"]? || 3).to_i
		interval    = (opts["interval"]? || 100).to_i
		port        = (opts["port"]? || 9).to_i
		magic_packet= create_magic_packet(mac_address)
		if opts["secure"]? && opts["secure"].to_s.size == 12
			magic_packet.write opts["secure"].to_s.hexbytes
		end	
		puts magic_packet.to_slice.hexdump
		socket = UDPSocket.new
		begin
			socket.connect(address.to_s,port)
			socket.broadcast = true
			socket.blocking = false
			(0..(num_packets-1)).each do |i|
				rc = socket.send magic_packet
				sleep (interval/1000)
			end
			yield true
		rescue ex : Exception
			yield false
		end		
  end 
  # convert mac address to string
  private def mac_to_bytes(mac : String)
	  parts = mac.split(/\:|\-/)
	  if(parts.size != 6)
		  raise Exception.new("Invalid MAC address") 
	  end
	  bytes = Slice.new(6){ |i| 0xff.to_u8 };
	  begin
		  (0..5).each do |i|
			  bytes[i] = parts[i].to_u8(16)
		  end	  
	  rescue ex : Exception
		  raise Exception.new("Invalid hex in mac address") 		  
	  end	  
	  return bytes
  end
  # create teh packet
  private def create_magic_packet(addr : String)	  
	  mac_slice = mac_to_bytes(addr)
	  magic_packet = IO::Memory.new(102)
	  header_slice = Slice.new(6) { |i| 0xff.to_u8 }
	  magic_packet.write(header_slice)
	  (0..15).each do
		  magic_packet.write(mac_slice)
	  end  
	  return magic_packet;	  
  end
end


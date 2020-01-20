# wol

TODO: Write a description here

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     wol:
       github: your-github-user/wol
   ```

2. Run `shards install`

## Usage

```crystal
require "wol"
```

- defaults
Wol.wake("mac address") do |results|
 if results
 	puts "Sent!"
 end
end

- options
Wol.wake("mac address",{"num_packets" => 3, "secure" => "hex password","port"=> 7, "address" =>"255.255.255.0"}) do |results|
 if results
 	puts "Sent!"
 end

end

## Development


## Contributing

1. Fork it (<https://github.com/your-github-user/wol/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Sal Scotto](https://github.com/your-github-user) - creator and maintainer

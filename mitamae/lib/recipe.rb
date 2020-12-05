puts "hostname: #{node[:hostname]}"
puts "platform: #{node[:platform]}"
puts "platform_version: #{node[:platform_version]}"

include_recipe 'recipe_helper'

include_role node[:platform]

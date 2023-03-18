puts "hostname: #{node[:hostname]}"
puts "platform: #{node[:platform]}"
puts "platform_version: #{node[:platform_version]}"
# puts "user: #{node[:user]}"
# puts "whoami: #{`whoami`}"

current_user = `whoami`.strip
current_user_info = node[:user][current_user]
puts "current_user: #{current_user}"
puts "current_user_info: #{current_user_info}"

include_recipe 'recipe_helper'

include_role node[:platform]

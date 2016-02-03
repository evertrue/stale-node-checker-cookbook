#
# Cookbook Name:: stale-node-checker
# Recipe:: default
#
# Copyright (C) 2014 EverTrue, Inc.
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'postfix'
include_recipe 'postfix::aliases'

search_args = {
  keys: {
    ohai_time: ['ohai_time'],
    name: ['name']
  },
  rows: node['stale-node-checker']['max-nodes']
}

threshold_time = Time.now.to_i - (
  node['stale-node-checker']['threshold']['days'] * 86_400 +
  node['stale-node-checker']['threshold']['hours'] * 3_600 +
  node['stale-node-checker']['threshold']['minutes'] * 60
)

partial_search(
  :node,
  "ohai_time:[* TO #{threshold_time}]",
  search_args
).first.each do |stale_node|
  next if node['stale-node-checker']['ignore'].include? stale_node['name']

  notifier "Stale node: #{stale_node['name']}" do
    to node['stale-node-checker']['alert-email']
    message 'The node <' + stale_node['name'] + '> has not checked in to ' \
      "Chef recently.\n\nThe last check-in was " \
      "#{Time.now.to_i - stale_node['ohai_time'].to_i} seconds ago."
  end
end

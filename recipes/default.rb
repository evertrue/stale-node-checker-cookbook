#
# Cookbook Name:: stale-node-checker
# Recipe:: default
#
# Copyright (C) 2014 EverTrue, Inc.
#
# All rights reserved - Do Not Redistribute
#

search_args = {
  :keys => {
    :ohai_time => ['ohai_time'],
    :name => ['name']
  },
  :rows => node['stale-node-checker']['max-nodes']
}

threshold_time = Time.now.to_i -
  (
    node['stale-node-checker']['threshold']['days'] * 86400 +
    node['stale-node-checker']['threshold']['hours'] * 3600 +
    node['stale-node-checker']['threshold']['minutes'] * 60
  )

stale_nodes = []

partial_search(
    :node,
    "ohai_time:[* TO #{threshold_time}]",
    search_args
  ).first.each do |stale_node|
  unless node['stale-node-checker']['ignore'].include?stale_node['name']
    msg = Chef::Recipe::StaleNodeChecker.check_last_run_time(node['ohai_time'].to_i)
    stale_nodes << stale_node['name']
  end
end

Chef::Log.info "Stale nodes: #{stale_nodes.join(', ')}"

notifier 'Stale nodes detected' do
  to node['stale-node-checker']['alert-email']
  message "The following nodes have not checked in to Chef recently: \n" +
    "\n  " +
    stale_nodes.join("\n  ") +
    "Threshold: " +
    node['stale-node-checker']['threshold']['days'].to_s + " days, " +
    node['stale-node-checker']['threshold']['hours'].to_s + " hours, " +
    node['stale-node-checker']['threshold']['minutes'].to_s + " minutes"
  not_if { stale_nodes.empty? }
end

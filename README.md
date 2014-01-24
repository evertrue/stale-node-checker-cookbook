# stale-node-checker-cookbook

Checks your Chef cluster for any nodes that haven't checked in recently and sends an alert if there are any.

## Supported Platforms

Tested on Ubuntu but isn't particularly platform specific.

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['stale-node-checker']['threshold']['days']/['stale-node-checker']['threshold']['hours']/['stale-node-checker']['threshold']['minutes']</tt></td>
    <td>Integer</td>
    <td>Days/Hours/Minutes that a server has to be out of touch before an alert is triggered</td>
    <td><tt>0/1/0 days/hours/minutes</tt></td>
  </tr>
  <tr>
    <td><tt>['stale-node-checker']['max-nodes']</tt></td>
    <td>Integer</td>
    <td>Maximum number of nodes to bother including in the alert</td>
    <td><tt>2500</tt></td>
  </tr>
  <tr>
    <td><tt>['stale-node-checker']['ignore']</tt></td>
    <td>Array</td>
    <td>The FULL node name of any nodes to ignore</td>
    <td><tt>Empty</tt></td>
  </tr>
  <tr>
    <td><tt>['stale-node-checker']['alert-email']</tt></td>
    <td>String</td>
    <td>Where to send the alerts</td>
    <td><tt>nil</tt></td>
  </tr>
</table>

## Usage

### stale-node-checker::default

Include `stale-node-checker` in a wrapper cookbook or role.

## License and Authors

Author:: EverTrue, Inc. (<eric.herot@evertrue.com>)

class Chef::Recipe::StaleNodeChecker
  def self.check_last_run_time(time)
    diff = Time.now.to_i - time
    minutes = (diff / 60)
    days = (minutes / 60 / 24)

    case
    when diff < 3600
        {
          :color => :green,
          :text => "#{minutes} minute#{minutes == 1 ? ' ' : 's'}"
        }
    when diff > 86400
        {
          :color => :red,
          :text => "#{days} day#{days == 1 ? ' ' : 's'}"
        }
    else
        {
          :color => :yellow,
          :text => "#{minutes / 60} hours"
        }
    end
  end
end

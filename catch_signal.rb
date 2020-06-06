child_process = 3
dead_process = 0

child_process.times do
  fork do
    sleep 3
  end
end

$stdout.sync = true

trap(:CHLD) do
  begin
    while pid = Process.wait(-1, Process::WNOHANG)
      puts pid
      dead_process += 1
    end
    rescue Errno::ECHILD
  end
end

loop do
  exit if dead_process == child_process
  sleep 1
end
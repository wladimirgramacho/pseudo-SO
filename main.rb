def main
  processes_file = File.open('processes.txt')
  lines = processes_file.readlines.map(&:chomp)
  processes = []
  lines.each do |line|
    line = line.split(',')
    processes << {
      init_time: line[0],
      priority: line[1],
      exec_time: line[2],
      memory_blocks: line[3],
      printer_id: line[4],
      scanner_req: line[5],
      modem_req: line[6],
      disk_number: line[7],
      offset: 0,
      pid: 0,
      executions: 0
    }
  end
  puts processes
end

main
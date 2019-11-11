class ProcessManager
  attr_accessor :processes

  def initialize
    processes_file = File.open('processes.txt')
    lines = processes_file.readlines.map(&:chomp)
    @processes = []
    lines.each_with_index do |line, index|
      line = line.split(',').map(&:to_i)
      @processes << {
        init_time: line[0],
        priority: line[1],
        exec_time: line[2],
        memory_blocks: line[3],
        printer_id: line[4],
        scanner_req: line[5],
        modem_req: line[6],
        disk_number: line[7],
        offset: find_offset(index),
        pid: index,
        executions: 0
      }
    end
    @processes.sort! { |a, b| a[:init_time] <=> b[:init_time] }
  end

  private

  def find_offset(index)
    index > 0 ? @processes.last[:offset] + @processes.last[:memory_blocks] + 1 : 0
  end
end
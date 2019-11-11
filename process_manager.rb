require_relative 'logger'

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
        scanner: line[5],
        modem: line[6],
        disk_number: line[7],
        offset: find_offset(index),
        pid: index,
        executions: 0
      }
    end
    @processes.sort! { |a, b| a[:init_time] <=> b[:init_time] }
  end

  def execute(instructions, memory)
    log = Logger.new

    instructions.each do |instruction|
      process = @processes[instruction[:pid]]
      if process[:executions] == 0
        log.dispatcher(process)
      end
      process[:executions] += 1

      if instruction[:code] == 0
        empty_space = memory.join.index('0' * instruction[:num_write_blocks])
        if empty_space.nil?
          puts "Não tem espaço para colocar o #{instruction[:filename]}"
          next
        end
        (empty_space...(empty_space + instruction[:num_write_blocks])).each do |index|
          memory[index] = instruction[:filename]
        end
      else
        index = memory.index(instruction[:filename])
        if index.nil?
          puts "O arquivo #{instruction[:filename]} não está em memória"
          next
        end
        memory = memory.map { |m| m == instruction[:filename] ? '0' : m }
      end
    end

    memory
  end

  private

  def find_offset(index)
    index > 0 ? @processes.last[:offset] + @processes.last[:memory_blocks] + 1 : 0
  end
end
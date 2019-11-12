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

    @processes.map { |p| p[:instructions] = instructions.select { |i| i[:pid] == p[:pid] } }

    @processes.each do |process|
      log.dispatcher(process)
      puts "process #{process[:pid]} =>"
      puts "\tP#{process[:pid]} STARTED"

      process[:instructions].each do |instruction|
        if instruction[:code] == 0
          empty_space = memory.join.index('0' * instruction[:num_write_blocks])
          if empty_space.nil?
            puts "\tP#{process[:pid]} instruction #{instruction[:op_number]} - FALHA"
            puts "\tNão tem espaço para colocar o arquivo #{instruction[:filename]}"
            next
          end
          blocks = (empty_space...(empty_space + instruction[:num_write_blocks])).to_a
          blocks.each do |index|
            memory[index] = instruction[:filename]
          end

          puts "\tP#{process[:pid]} instruction #{instruction[:op_number]} - SUCESSO"
          puts "\tO processo #{process[:pid]} criou o arquivo #{instruction[:filename]} (blocos #{blocks})"
        else
          index = memory.index(instruction[:filename])
          if index.nil?
            puts "\tP#{process[:pid]} instruction #{instruction[:op_number]} - FALHA"
            puts "\tO arquivo #{instruction[:filename]} não está em memória"
            next
          end
          memory = memory.map { |m| m == instruction[:filename] ? '0' : m }
        end
      end

      puts "\tP#{process[:pid]} SIGINT"
    end
    memory
  end

  private

  def find_offset(index)
    index > 0 ? @processes.last[:offset] + @processes.last[:memory_blocks] + 1 : 0
  end
end
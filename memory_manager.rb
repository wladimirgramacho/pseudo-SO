require 'byebug'

class MemoryManager
  attr_accessor :memory, :instructions

  def initialize
    memory_file = File.open('files.txt')
    lines = memory_file.readlines.map(&:chomp)
    @memory = Array.new(lines[0].to_i)
    segments_in_memory = lines[1].to_i
    lines[2..(segments_in_memory + 1)].each do |segment|
      segment = segment.split(',')
      start = segment[1].to_i
      (start...(segment[2].to_i + start)).each_with_index do |index, _|
        @memory[index] = segment[0]
      end
    end
    @instructions = []
    lines[(segments_in_memory + 2)..].each do |instruction|
      instruction = instruction.split(',').map(&:to_i)
      @instructions << {
        pid: instruction[0],
        code: instruction[1],
        filename: instruction[2],
        num_write_blocks: instruction[1] == 0 ? instruction[3] : nil,
        op_number: instruction.last
      }
    end
  end
end
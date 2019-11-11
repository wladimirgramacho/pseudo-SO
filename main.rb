require_relative 'process_manager'
require_relative 'memory_manager'
require_relative 'logger'

def main
  process_manager = ProcessManager.new
  memory_manager = MemoryManager.new
  log = Logger.new

  process_manager.execute(memory_manager.instructions, memory_manager.memory)
  log.memory(memory_manager.memory)
end

main
require_relative 'process_manager'

def main
  process_manager = ProcessManager.new
  puts process_manager.processes
end

main
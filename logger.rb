class Logger
  def dispatcher(process)
    puts 'dispatcher =>'
    puts "\t PID:\t\t\t #{process[:pid]}"
    puts "\t offset:\t\t #{process[:offset]}"
    puts "\t blocos em memória:\t #{process[:memory_blocks]}"
    puts "\t prioridade:\t\t #{process[:priority]}"
    puts "\t tempo de processador:\t #{process[:exec_time]}"
    puts "\t impressoras:\t\t 0"
    puts "\t scanners:\t\t #{process[:scanner]}"
    puts "\t modems:\t\t #{process[:modem]}"
    puts "\t drivers:\t\t 0"
  end

  def memory(memory)
    puts 'Mapa de ocupação do disco'
    print '|'
    memory.each { |m| print "#{m == 0 ? ' ' : m}|" }
    puts
  end
end
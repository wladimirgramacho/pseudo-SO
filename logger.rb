class Logger
  def dispatcher(process)
    puts 'dispatcher =>'
    puts "  PID:\t\t\t #{process[:pid]}"
    puts "  offset:\t\t #{process[:offset]}"
    puts "  blocos em memória:\t #{process[:memory_blocks]}"
    puts "  prioridade:\t\t #{process[:priority]}"
    puts "  tempo de processador:\t #{process[:exec_time]}"
    puts "  impressoras:\t\t 0"
    puts "  scanners:\t\t #{process[:scanner]}"
    puts "  modems:\t\t #{process[:modem]}"
    puts "  drivers:\t\t 0"
  end

  def memory(memory)
    print("\n")
    puts 'Mapa de ocupação do disco'
    print '|'
    memory.each { |m| print "#{m == '0' ? ' ' : m}|" }
    print("\n")
  end
end
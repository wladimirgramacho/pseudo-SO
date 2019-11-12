class IOManager
  attr_accessor :devices

  def initialize
    @devices = {
      'scanner' => 0,
      'printer' => [0, 0],
      'modem' => 0,
      'sata_device' => [0, 0]
    }
  end

  def alloc(process)
    unless @devices['scanner']
      @devices['scanner'] = process['pid']
    end
    unless @devices['modem']
      @devices['modem'] = process['pid']
    end
      
    if process['printer_id'] > 0
      unless @devices['printer'][process['printer_id']-1]
        @devices['printer'][process['printer_id']-1] = process['pid']
      end
    end
    if process['disk_number'] > 0
      unless @devices['sata_device'][process['disk_number']-1]
        @devices['sata_device'][process['disk_number']-1] = process['pid']
      end
    end
  end

  def free(process)
    if @devices['scanner'] == process['pid']
      @devices['scanner'] = 0
    end
    if @devices['modem'] == process['pid']
      @devices['modem'] = 0
    end

    if process['pid'] == @devices['printer'][process['printer_id']-1]
      @devices['printer'][process['printer_id']-1] = 0
    end
    if process['pid'] == @devices['sata_device'][process['disk_number']-1]
      @devices['sata_device'][process['disk_number']-1] = 0
    end    
  end
end
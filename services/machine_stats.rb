require 'pry'
class MachineStats
  def cpu_usage
    proc0      = File.readlines('/proc/stat').grep(/^cpu /).first.split(" ")
    proc_usage = proc0[1].to_i + proc0[2].to_i + proc0[3].to_i
    proc_total = 0

    for i in (1..4) do
      proc_total += proc0[i].to_i
    end

    @cpu_usage = (proc_usage.to_f / proc_total.to_f).round(3)
  end

  def cpu_usage_in_percentage
    @cpu_usage_percentage = (100 * cpu_usage).to_f.round(2)
  end

  # In KB
  def mem_total
    mem_stats = find_mem_stats
    @mem_total = mem_stats[0].gsub(/[^0-9]/, "").to_i
  end

  def mem_active
    mem_stats = find_mem_stats
    @mem_active = mem_stats[5].gsub(/[^0-9]/, "").to_i
  end

  def mem_usage_percentage
    mem_active_calc = (mem_active.to_f * 100) / mem_total.to_f
    @mem_usage_percentage = mem_active_calc.round
  end

  def running_process
    @process = []
    find_running_process.each_line do |line|
      line = line.chomp.split(" ")
      @process << line.first.gsub(/[\[\]]/, "")
    end

    @process
  end

  private

  def find_mem_stats
    @mem_stats ||= File.readlines('/proc/meminfo')
  end

  def find_running_process
    @running_process ||= `ps aux | awk '{print $11, $4}' | sort -k2nr  | head -n 10`
  end

end

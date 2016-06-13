require 'minitest/autorun'
require_relative '../services/machine_stats.rb'

class TestMachineStats < Minitest::Test
  def setup
    @proc_stats    = File.readlines("#{__dir__}/supports/proc_stats_fixture.txt")
    @mem_info      = File.readlines("#{__dir__}/supports/proc_meminfo_fixture.txt")
    @top_process   = File.read("#{__dir__}/supports/top_ten_process.txt")

    @machine_stats = MachineStats.new
  end

  def test_that_it_returns_cpu_usage
    File.stub :readlines, @proc_stats do
      assert_equal 0.203, @machine_stats.cpu_usage
    end
  end

  def test_that_it_returns_cpu_usage_in_percentage
    File.stub :readlines, @proc_stats do
      assert_equal 20.3, @machine_stats.cpu_usage_in_percentage
    end
  end

  def test_that_it_returns_mem_total
    File.stub :readlines, @mem_info do
      assert_equal 16400804, @machine_stats.mem_total
    end
  end

  def test_that_it_returns_mem_active
    File.stub :readlines, @mem_info do
      assert_equal 3242308, @machine_stats.mem_active
    end
  end

  def test_that_it_returns_mem_usage_percentage
    File.stub :readlines, @mem_info do
      assert_equal 20, @machine_stats.mem_usage_percentage
    end
  end

  def test_that_it_returns_top_ten_process
    @machine_stats.stub :find_running_process, @top_process do
      assert_equal ['/opt/google/chrome/chrome',
        '/opt/google/chrome/chrome',
        '/opt/google/chrome/chrome',
        '/opt/google/chrome/chrome',
        '/opt/google/chrome/chrome',
        '/opt/sublime_text/sublime_text',
        '/opt/google/chrome/chrome',
        '/usr/share/spotify/spotify',
        '/opt/google/chrome/chrome',
        '/opt/google/chrome/chrome'], @machine_stats.running_process
    end
  end
end

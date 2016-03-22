begin
  require "fiber"
rescue LoadError
  raise LoadError.new "em-rspec requires the Fiber class. ("\
  "Available in core Ruby 1.9)"
end

require "eventmachine"

RSpec::Core::Example.class_eval do
  alias ignorant_run run

  def run(example_group_instance, reporter)
    Fiber.new do
      EM.run do
        df = EM::DefaultDeferrable.new
        result = nil
        df.callback do |_x|
          EM.stop_event_loop
          Fiber.yield result
        end
        result = ignorant_run example_group_instance, reporter
        df.succeed
      end
    end.resume
  end
end

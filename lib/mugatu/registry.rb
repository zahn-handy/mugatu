module Mugatu
  class Registry
    def initialize
      @linters = {}
    end

    def formatter_registry
      formatter_list
        .map { |formatter| [formatter.identifier, formatter] }
        .to_h
    end

    def linters
      linter_list
        .map { |linter| [linter.identifier, linter] }
        .to_h
    end

    private

    def formatter_list
      Mugatu::Formatters.constants.map do |formatter_class_name|
        Mugatu::Formatters.const_get(formatter_class_name)
      end
    end

    def linter_list
      Mugatu::Drivers.constants.map do |driver_class_name|
        Mugatu::Drivers.const_get(driver_class_name)
      end
    end
  end
end

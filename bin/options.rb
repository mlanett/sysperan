# -*- encoding: utf-8 -*-

require "optparse"

class Options

  def self.parse( argv = ARGV )
    new.tap do |options|
      OptionParser.new do |op|
        op.banner = "Usage: #{__FILE__} [options]* options_file"
        op.on( "-h", "--help",         "Display this usage summary." ) { puts op; exit }
        op.on( "-o", "--options file", "Include options file.")        { |s| options.load_script(s) }
      end.parse!(argv)

      while argv.any? && File.exists?(argv.first) do
        options.load_file( argv.shift )
      end
    end
  end

  def initialize
    @n = 1
  end

  def load_script(string)
    instance_eval(string)
  end

  def load_file(filename)
    instance_eval(File.read(filename),filename)
  end

  # ----------------------------------------------------------------------------
  # Options DSL
  # Reminder: you can't have assignment methods in a DSL.
  # ----------------------------------------------------------------------------

  def interval n
    @n = n
  end

end

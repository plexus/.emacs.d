#!/usr/bin/env ruby

require 'socket'
require 'rspec/core'
require 'rspec/core/formatters/base_formatter'
require 'simplecov'

p ARGV

Cons = Struct.new(:car, :cdr)

COXIT_PASSTHROUGH_ARGS = {}

until (arg = ARGV.shift) == "--"
  k, v = arg.split(':')
  COXIT_PASSTHROUGH_ARGS[k.to_sym] = v
end

def Sexp(expr)
  case expr
  when Array
    "(#{expr.map(&method(:Sexp)).join(' ')})"
  when Cons
    "(#{Sexp(expr.car)} . #{Sexp(expr.cdr)})"
  when Hash
    Sexp(expr.map {|k,v| Cons.new(k,v) })
  when String
    %["#{expr.gsub('\\', '\\\\').gsub('"', '\"')}"]
  when Numeric
    expr.to_s
  when NilClass
    "nil"
  when Symbol
    expr.to_s
  end
end

def coxit_respond(type, expr)
  TCPSocket.open('localhost', 10042) do |socket|
    #puts Sexp(expr)
    socket << Sexp(
      COXIT_PASSTHROUGH_ARGS.merge(
        type: type,
        results: expr
      )
    )
  end
end

class SimplecovSexpFormatter
  def format(result)

    # result.files.map do |file|
    #   covered, total = file.coverage.reduce([0, 0]) do |(covered, total), linecov|
    #     [covered + (linecov && linecov > 0 ? 1 : 0), total + (linecov ? 1 : 0) ]
    #   end
    #   [ file.filename, total > 0 ? Float(covered)/total*100 : 0 ]
    # end.sort_by(&:last).each do |filename, covpct|
    #   puts " %s%.2f | %s" % [covpct < 100 ? ' ' : '' , covpct, filename]
    # end

    coxit_respond(:coverage,
      result.files.map do |file|
        Cons.new(file.filename, file.coverage)
      end
    )
  end
end

class RSpecSexpFormatter <  RSpec::Core::Formatters::BaseFormatter
  def dump_summary(duration, example_count, failure_count, pending_count)
    coxit_respond(:spec_summary,
      { duration: duration,
        example_count: example_count,
        failure_count: failure_count,
        pending_count: pending_count
      }
    )
  end
end

SimpleCov.start
SimpleCov.formatter = SimplecovSexpFormatter

RSpec.configure do |c|
  c.formatters.clear
  c.add_formatter('progress', $stdout)
  c.add_formatter(RSpecSexpFormatter, $stdout)
end

at_exit do
  next unless $!.nil? || $!.kind_of?(SystemExit)

  options = RSpec::Core::ConfigurationOptions.new(ARGV)
  options.parse_options
  def options.options
    super.reject {|k,v| k == :formatters}
  end

  status = RSpec::Core::CommandLine.new(options).run($stderr, $stdout).to_i

  exit status if status != 0
end

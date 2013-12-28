#!/usr/bin/env ruby

require 'socket'
require 'rspec/core'
require 'rspec/core/formatters/base_formatter'
require 'simplecov'

Cons = Struct.new(:car, :cdr)

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

def coxit_respond(expr)
  TCPSocket.open('localhost', 10042) do |socket|
    #puts Sexp(expr)
    socket << Sexp(expr)
  end
end

class SimplecovSexpFormatter
  def format(result)
    coxit_respond(:coverage =>
      result.files.map do |file|
        Cons.new(file.filename, file.coverage)
      end
    )
  end
end

class RSpecSexpFormatter <  RSpec::Core::Formatters::BaseFormatter
  def dump_summary(duration, example_count, failure_count, pending_count)
    coxit_respond(:result =>
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
  c.formatter = 'progress'
  c.formatter = RSpecSexpFormatter
end

require 'rspec/autorun'

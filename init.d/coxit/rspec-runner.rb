#!/usr/bin/env ruby

require 'socket'

class SimplecovSexpFormatter
  Cons = Struct.new(:car, :cdr)

  def format(result)
    TCPSocket.open('localhost', 10042) do |socket|
      socket << to_sexp(
        result.files.map do |file|
          Cons.new(file.filename, file.coverage)
        end
      )
    end
  end

  def to_sexp(expr)
    case expr
    when Array
      "(#{expr.map(&method(:to_sexp)).join(' ')})"
    when Cons
      "(#{to_sexp(expr.car)} . #{to_sexp(expr.cdr)})"
    when String
      %["#{expr.gsub('\\', '\\\\').gsub('"', '\"')}"]
    when Numeric
      expr.to_s
    when NilClass
      "nil"
    when Symbol
      "'#{expr}"
    end
  end
end

require 'simplecov'

SimpleCov.start
SimpleCov.formatter = SimplecovSexpFormatter

require 'rspec/autorun'

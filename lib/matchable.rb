# Matchable
# Ruby Module
# Copyright (C) 2006 Mark Friedgan <mark-gpl@cashnetusa.com>
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

require 'rinda/ring'
require 'rinda/tuplespace'
require 'rinda/rinda'

#
#
#load 'matchable.rb'
#class Foo
#include Matchable
#
#def_match :killer, /hell/, nil do 
#  |a, b| 
#    puts a,b 
#  end
#
#def_match :killer, /hell/, nil, nil do 
#  |a, b, c| 
#    puts c,a,b 
#  end
#end
#
#foo = Foo.new
#
#foo.killer "hello", "world"
# hello
# world
#
#foo.killer "hello", "world", "welcome"
#
#
#This uses tuple matching (i.e. ===)
#
#This class also defines mcase which allows this type of matching in case statements
#class Food
#include Matchable
# def test(tuple)
#  case tuple
#    when mcase([:test, 5, 5]) then "poop"
#    when mcase([:test, nil, nil]) then "whoop"
#    when mcase([nil, nil]) then "hoot"
#    else "foot"
#  end
# end
#end
#
#
#also supports hash matching for case statements (not for def_match's yet, dont really know how)
# case {:t => 5, :g => "help"}
#   when mcase({:t => 5, :g => "hello"}) then "pop"
#   when mcase({:t => 5}) then "fop"
#   else "mop"
# end

module Matchable

  def self.append_features(base) #:nodoc:
    super
    base.extend(ClassMethods)
  end

  class CaseMatcher
    def initialize(tuple) 
      if tuple.is_a?(Hash) then
        @temp = tuple
        @keys = tuple.keys
      else
        @temp = Rinda::TemplateEntry.new(tuple) 
      end
    end
    
    def ===(a) 
      if a.is_a?(Hash) then
        Rinda::TemplateEntry.new(hash_convert(@temp)).match(Rinda::TupleEntry.new(hash_convert(a)))
      else
        @temp.match Rinda::TupleEntry.new(a) 
      end
    end

    def hash_convert(tuple)
      @keys.collect{|key| tuple[key]}
    end
  end

  def mcase(tuple)
    CaseMatcher.new(tuple) 
  end


  module ClassMethods
    def def_match(method, *args, &block)
      raise 'Bad match' unless args.length > 0
      raise 'Block required' unless block_given?
      @@match_hash ||= Rinda::TupleBag.new
      @@block_hash ||= {}
      tuple = *([method] + args)
      #put an array into the bag that contains the template and the block
      @@match_hash.push(Rinda::TemplateEntry.new(tuple))
      @@block_hash[tuple] = block
      
      class_eval  <<-EOV
      def #{method}(*args)
        self.class.call_match(:#{method}, *args)
      end 
      EOV
    end

    def call_match(method, *args)
      exec_tuple = find_block([method] + args)
      method_missing(method, *args) unless exec_tuple
      block = @@block_hash[exec_tuple]
      method_missing(method, *args) unless block
      block.call *args    
    end

    
    private
    def find_block(ary)
      match = @@match_hash.find_all_template(Rinda::TupleEntry.new(ary)).sort{|x, y| 
        y.value.compact.size <=> x.value.compact.size}.first
      match && match.value 
    end

  end


end






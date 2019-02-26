#!/usr/bin/ruby -w

require_relative 'game.rb'

game = Game.new
loop { break unless game.turn }

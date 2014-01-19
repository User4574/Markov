#!/usr/bin/env ruby

require './markov-analyse.rb'
require './markov-generate.rb'
require 'readline'

$replstate = Hash.new

def handle_input(inputs)
	input = inputs.split
	case input[0]
	when 'load'
		case input[1]
		when 'corpus'
			$replstate[:analyser] = Markov::Analyser.new(input[2], input[3].to_i)
		when 'serial'
			$replstate[:generator] = Markov::Generator.new(input[2])
		end
	when 'analyse'
		$replstate[:analyser].analyse
	when 'save'
		$replstate[:analyser].save(input[1])
	when 'generate'
		$replstate[:generator].generate(input[1].to_i)
	when 'quit'
		puts
		exit
	end
end

trap('INT'){puts; exit}

while line = Readline.readline('>> ', true) do
	handle_input(line)
end

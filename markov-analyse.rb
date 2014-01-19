module Markov
	class Analyser
		def initialize(inputfile, chunklength)
			@chunklength = chunklength
			@stats = {"__SETTINGS__" => {"__CHUNKLENGTH__" => @chunklength}}

			@words = File.readlines(inputfile)
						 .map(&:split)
						 .flatten
		end

		def analyse
			(0 .. (@words.length - @chunklength - @chunklength)).each do |i|
				k = @words[i...(i+@chunklength)]
				v = @words[(i+@chunklength)]
				if @stats.include?(k) then
					t = @stats[k]
					if t.include?(v) then
						t[v] += 1
					else
						t[v] = 1
					end
				else
					@stats[k] = Hash.new
					@stats[k][v] = 1
				end
			end
		end

		def save(outputfile)
			File.new(outputfile, "w").print(Marshal::dump(@stats))
		end
	end
end

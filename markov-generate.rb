module Markov
	class Generator
		def initialize(input, type=:var)
			@prng = Random.new(Time.now.to_i)
			if type == :var then
				@stats = input
			elsif type == :file then
				@stats = Marshal::load(File.open(input).read)
			end
			@chunklength = @stats["__SETTINGS__"]["__CHUNKLENGTH__"]
		end

		def cfd(hash)
			tot = 0
			hash.each_pair {|k, v|
				hash[k] = tot += v
			}
		end

		def sel(hash)
			max = hash.values.max
			r = @prng.rand(max*100000) % max
			hash.each_pair {|k, v|
				return k if r < v
			}
		end

		def aword(chunk, hash)
			sel(cfd(hash[chunk]))
		end

		def generate(length)
			current = @stats.keys.select{|k| k != "__SETTINGS__" }.sample

			(length - @chunklength).times do
				current << aword(current[-@chunklength..-1], @stats)
			end

			puts current.join(" ")
		end
	end
end

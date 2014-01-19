#!/usr/bin/env ruby

PRNG = Random.new(Time.now.to_i)

STATS = Marshal::load(File.open(ARGV[0]).read)

CHUNK = STATS["__SETTINGS__"]["__CHUNK__"]

NUM = (ARGV[2] or "1").to_i

def cfd(hash)
	tot = 0
	hash.each_pair {|k, v|
		hash[k] = tot += v
	}
end

def sel(hash)
	max = hash.values.max
	r = PRNG.rand(max*100000) % max
	hash.each_pair {|k, v|
		return k if r < v
	}
end

def aword(chunk, hash)
	sel(cfd(hash[chunk]))
end

NUM.times do
	current = STATS.keys.select{|k| k != "__SETTINGS__" }.sample

	(ARGV[1].to_i - CHUNK).times do
		current << aword(current[-CHUNK..-1], STATS)
	end

	puts current.join(" ")
	puts
end

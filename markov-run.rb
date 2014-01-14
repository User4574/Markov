#!/usr/bin/env ruby

PRNG = Random.new(Time.now.to_i)

stats = Marshal::load(File.open(ARGV[0]).read)

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

current = stats.keys.select{|k|k.first.match(/^[A-Z]/)}.sample

print "#{current.join(" ")} "

def achunk(chunk, hash)
	sel(cfd(hash[chunk]))
end

(ARGV[1].to_i - 1).times do
	current = achunk(current, stats)
	print "#{current.join(" ")} "
end

puts

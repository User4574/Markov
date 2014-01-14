#!/usr/bin/env ruby

CHUNK = ARGV[1].to_i

stats = Hash.new

words = File.readlines(ARGV[0])
		.map(&:split)
		.flatten

(0 .. (words.length - CHUNK - CHUNK)).each do |i|
	k = words[i...(i+CHUNK)]
	v = words[(i+CHUNK)...(i+CHUNK+CHUNK)]
	if stats.include?(k) then
		t = stats[k]
		if t.include?(v) then
			t[v] += 1
		else
			t[v] = 1
		end
	else
		stats[k] = Hash.new
		stats[k][v] = 1
	end
end

File.new(ARGV[2], "w").print(Marshal::dump(stats))



save = File.open('save.txt', 'r')
classobj = save.read
classobj2 = Oj::load classobj, :indent => 2

puts classobj2.word
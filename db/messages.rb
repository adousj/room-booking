puts 'create message'

10.times do |i|
  Account.first.messages.create(:content => "the number is #{i}")
end
Facter.add('ekeyd_key_present') do
  confine :kernel => %w{Linux}
  setcode do
    !`lsusb | grep "Entropy Key"`.empty?
  end
end

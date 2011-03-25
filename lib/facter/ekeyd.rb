Facter.add('ekeyd_key_present') do
  confine :kernel => %w{Linux}
  setcode do
    !Kernel.exec('lsusb | grep "Entropy Key"').empty?
  end
end

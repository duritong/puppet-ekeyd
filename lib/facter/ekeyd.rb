Facter.add('ekeyd_key_present') do
  setcode do
    FileTest.exists?('/proc/bus/usb/devices') && \
      !(File.read('/proc/bus/usb/devices') =~ /Product=Entropy Key/).nil?
  end
end
Facter.add('ekeyd_key_present') do
  confine :operatingsystem => %w{Debian}
  setcode do
    FileTest.exists?('/proc/bus/usb/devices') && \
    !`lsusb | grep "Entropy Key"`.empty?
  end
end

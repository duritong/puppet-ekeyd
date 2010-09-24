Facter.add('ekeyd_key_present') do
  confine :kernel => %w{Linux}
  setcode do
    FileTest.exists?('/proc/bus/usb/devices') && \
      !(File.read('/proc/bus/usb/devices') =~ /Product=Entropy Key/).nil?
  end
end

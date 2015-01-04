Facter.add('ekeyd_key') do
  setcode do
    Dir.glob("/dev/serial/by-id/usb-Simtec_Electronics_Entropy_Key*").first
  end
end

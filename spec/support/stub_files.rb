
def stub_read_file fn, with_content: ""
  expect( File ).to receive(:read).with(fn).and_return with_content
end

def stub_file_does_not_exist fn
  expect( File ).to receive(:read).with(fn){ raise Errno::ENOENT, "No such file or directory - #{fn}" }
end

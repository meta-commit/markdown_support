def file_fixture(fixture)
  File.read(File.join(File.dirname(__dir__), 'fixtures', *fixture))
end
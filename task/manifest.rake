desc 'Generates the MANIFEST file'
task :manifest do
  FILE_LIST = FileList.new(
    'checkum/**/*.*',
    'doc/**/*.*',
    'lib/**/*.*',
    'bin/*',
    'assets/**/*.*',
    'assets/**/*',
    'LICENSE.txt',
    'MANIFEST',
    '*.gemspec',
    'README.md',
    '.yardopts'
  )

  files  = FILE_LIST.to_a.sort
  handle = File.open(File.expand_path('../../MANIFEST', __FILE__), 'w')

  handle.write(files.join("\n"))
  handle.close
end

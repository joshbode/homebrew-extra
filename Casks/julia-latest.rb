cask 'julia-latest' do
  version '0.5.0-rc4'
  sha256 '8d3589ae5a4ad4a19c3bc0c9441383e047d1cac3365a7cf71825412ed90e6796'

  version_number = version.sub(%r{(\d+\.\d+).*}, '\1')
  url "https://s3.amazonaws.com/julialang/bin/osx/x64/#{version_number}/julia-#{version_number}-latest-osx10.7+.dmg"
  name 'Julia'
  homepage 'http://julialang.org'
  license :mit

  depends_on macos: '>= :lion'

  app "Julia-#{version_number}.app"
  binary "#{appdir}/Julia-#{version_number}.app/Contents/Resources/julia/bin/julia", target: "julia-#{version_number}"

  zap delete: '~/.julia'
end

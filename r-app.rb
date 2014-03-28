require 'formula'

class RApp < Formula

  homepage 'http://cran.r-project.org/bin/macosx/'
  url 'http://cran.r-project.org/bin/macosx/Mac-GUI-1.62.tar.gz'
  version '1.62'
  sha1 '3f7ef605076cf537b304a05d979ae44d3cb054ab'

  head 'svn://svn.r-project.org/R-packages/trunk'

  depends_on :xcode
  depends_on 'r'

  if !Hardware.is_64_bit?
    onoe "Cannot compile on 32-bit architecture."
  end
  if MacOS.version >= :mountain_lion
    CONFIG = "MLion64"
  elsif MacOS.version >= :lion
    CONFIG = "Lion64"
  elsif MacOS.version >= :snow_leopard
    CONFIG = "SnowLeopard64"
  else
    onoe "Requires Mac OS X Snow Leopard (10.6) or later."
  end

  def install
    if !File.exist?("/Library/Frameworks/R.framework")
      ln_s "#{HOMEBREW_PREFIX}/opt/r/R.framework",
           "/Library/Frameworks/R.framework"
    end

    system "xcodebuild -target R -configuration #{CONFIG}"

    prefix.install "build/#{CONFIG}/R.app", "/Applications/R.app"
  end
end

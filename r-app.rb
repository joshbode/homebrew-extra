require 'formula'

class RApp < Formula

  homepage 'http://cran.r-project.org/bin/macosx/'
  url 'http://cran.r-project.org/bin/macosx/Mac-GUI-1.62.tar.gz'
  sha1 '3f7ef605076cf537b304a05d979ae44d3cb054ab'

  head 'https://svn.r-project.org/R-packages/trunk/Mac-GUI'

  depends_on :xcode
  depends_on :macos => :snow_leopard
  depends_on :arch => :x86_64

  depends_on 'r'

  if MacOS.version >= :mountain_lion
    CONFIG = "MLion64"
  elsif MacOS.version >= :lion
    CONFIG = "Lion64"
  elsif MacOS.version >= :snow_leopard
    CONFIG = "SnowLeopard64"
  end

  def install
    # ugly hack to get updateSVN script in build to not fail
    if build.head?
      cp_r cached_download/".svn", buildpath
    end

    xcodebuild "-target", "R",
               "-configuration", "#{CONFIG}",
               "SYMROOT=build",
               "HEADER_SEARCH_PATHS=#{Formula['r'].opt_prefix}/R.framework/Headers",
               "OTHER_LDFLAGS=-F#{Formula['r'].opt_prefix}"

    prefix.install "build/#{CONFIG}/R.app"
  end
end

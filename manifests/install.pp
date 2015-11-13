# Install a given version of Wix
define wix::install($url, $version, $tempFolder = 'C:/temp') {

  require archive

  if (!defined(File[$tempFolder]))
  {
    file { $tempFolder:
      ensure   => directory,
    }
  }

  archive { "${tempFolder}/wix${version}.exe":
    source  => $url,
    require => File[$tempFolder],
  }
  ->
  package { "WiX Toolset v${version}" :
    source          => "${tempFolder}/wix${version}.exe",
    install_options => ['/Quiet', '/NoRestart'],
  }
}

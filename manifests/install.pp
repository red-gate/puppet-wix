# Install a given version of Wix
define wix::install($url, $version, $tempFolder = 'C:/temp') {

  if (!defined(File[$tempFolder]))
  {
    file { $tempFolder:
      ensure   => directory,
    }
  }

  exec { "${tempFolder}/wix${version}.exe":
    command  => "\$ProgressPreference='SilentlyContinue'; Invoke-WebRequest '${url}' -OutFile '${tempFolder}/wix${version}.exe'",
    provider => powershell,
    creates  => "${tempFolder}/wix${version}.exe",
    require  => File[$tempFolder],
  }
  ->
  package { "WiX Toolset v${version}" :
    source          => "${tempFolder}/wix${version}.exe",
    install_options => ['/Quiet', '/NoRestart'],
  }
}

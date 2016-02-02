# Install a given version of Wix
define wix::install($version, $tempfolder = 'C:/temp') {

  if($::architecture == 'x86') {
    $programfilesx86 = 'C:/Program Files'
  } else {
    $programfilesx86 = 'C:/Program Files (x86)'
  }

  if($version == '2.0') {
    $url = 'https://wix.codeplex.com/downloads/get/119159'
    $installfolder = "${programfilesx86}/Windows Installer XML"
  }
  if($version == '3.5') {
    $url = 'https://wix.codeplex.com/downloads/get/204418'
    $installfolder = "${programfilesx86}/Windows Installer XML v3.5"
  }
  if($version == '3.6') {
    $url = 'https://wix.codeplex.com/downloads/get/482066'
    $installfolder = "${programfilesx86}/Windows Installer XML v3.6"
  }
  if($version == '3.7') {
    $url = 'https://wix.codeplex.com/downloads/get/582220'
    $installfolder = "${programfilesx86}/WiX Toolset v3.7"
  }
  if($version == '3.8') {
    $url = 'https://wix.codeplex.com/downloads/get/762938'
    $installfolder = "${programfilesx86}/WiX Toolset v3.8"
  }
  if($version == '3.10') {
    $url = 'https://wix.codeplex.com/downloads/get/1483378'
    $installfolder = "${programfilesx86}/WiX Toolset v3.10"
  }

  $directories = [ $tempfolder,
    $installfolder,
    "${installfolder}/bin",
    "${installfolder}/loc",
    ]

  ensure_resource('file', $directories, { ensure => directory })

  exec { "Download wix.${version}.zip":
    command  => "\$ProgressPreference = 'SilentlyContinue'; Invoke-WebRequest '${url}' -OutFile '${tempfolder}/wix.${version}.zip'",
    provider => powershell,
    creates  => "${tempfolder}/wix.${version}.zip",
  }
  ->
  archive { "${tempfolder}/wix.${version}.zip":
    extract      => true,
    extract_path => "${installfolder}/bin",
    creates      => "${installfolder}/bin/candle.exe",
    cleanup      => true,
    require      => [File["${installfolder}/bin"], File[$tempfolder]],
  }
  ->
  file { "${installfolder}/loc/WixUI_en-us.wxl":
    ensure             => file,
    source             => 'puppet:///modules/wix/WixUI_en-us.wxl',
    source_permissions => ignore,
    require            => File["${installfolder}/loc"],
  }
  ->
  windows_env { "WIX_VERSION=${version}": }
}

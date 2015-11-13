# Install Wix 3.7
class wix::3_7(
  $url = 'https://wix.codeplex.com/downloads/get/582218',
  $version = '3.7.1224.0',
  $tempFolder = 'C:/temp') {

  wix::install {"Wix ${version}":
    url        => $url,
    version    => $version,
    tempFolder => $tempFolder,
  }

}

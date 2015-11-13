# Install Wix 3.8
class wix::3_8(
  $url = 'https://wix.codeplex.com/downloads/get/762937',
  $version = '3.8.1128.0',
  $tempFolder = 'C:/temp') {

  wix::install { "Wix ${version}":
    url        => $url,
    version    => $version,
    tempFolder => $tempFolder,
  }

}

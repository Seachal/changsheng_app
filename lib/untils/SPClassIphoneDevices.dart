class SPClassIphoneDevices{


  String spFunDevicesString(String deivice){
    
 
  if(deivice.startsWith("iPhone")){
    return spFunIPhonePlatform(deivice);
  }

  if(deivice.startsWith("iPad")){
    return spFunIPadPlatform(deivice);
  }

  if(deivice.startsWith("iPod")){
    return spFunIPodPlatform(deivice);
  } 
  
  if(deivice.contains("i386")){
    return "Simulator";
  } 
  
  if(deivice.contains("x86_64")){
    return "Simulator";
  }


  return "Unknown iOS Device";
  
}

//iPhone设备
String spFunIPhonePlatform(String deivice){

if (deivice=="iPhone1,1") return "iPhone 2G";
if (deivice=="iPhone1,2") return "iPhone 3G";
if (deivice=="iPhone2,1") return "iPhone 3GS";
if (deivice=="iPhone3,1") return "iPhone 4";
if (deivice=="iPhone3,2") return "iPhone 4";
if (deivice=="iPhone3,3") return "iPhone 4";
if (deivice=="iPhone4,1") return "iPhone 4S";
if (deivice=="iPhone5,1")    return "iPhone 5";
if (deivice=="iPhone5,2")    return "iPhone 5";
if (deivice=="iPhone5,3")    return "iPhone 5c";
if (deivice=="iPhone5,4")    return "iPhone 5c";
if (deivice=="iPhone6,1")    return "iPhone 5s";
if (deivice=="iPhone6,2")    return "iPhone 5s";
if (deivice=="iPhone7,2")    return "iPhone 6";
if (deivice=="iPhone7,1")    return "iPhone 6 Plus";
if (deivice=="iPhone8,1")    return "iPhone 6s";
if (deivice=="iPhone8,2")    return "iPhone 6s Plus";
if (deivice=="iPhone8,4")    return "iPhone SE";
if (deivice=="iPhone9,1")    return "iPhone 7";
if (deivice=="iPhone9,3")    return "iPhone 7";
if (deivice=="iPhone9,2")    return "iPhone 7 Plus";
if (deivice=="iPhone9,4")    return "iPhone 7 Plus";
//2017年9月发布，更新三种机型：iPhone 8、iPhone 8 Plus、iPhone X
if (deivice=="iPhone10,1")  return "iPhone 8";
if (deivice=="iPhone10,4")  return "iPhone 8";
if (deivice=="iPhone10,2")  return "iPhone 8 Plus";
if (deivice=="iPhone10,5")  return "iPhone 8 Plus";
if (deivice=="iPhone10,3")  return "iPhone X";
if (deivice=="iPhone10,6")  return "iPhone X";
//2018年10月发布，更新三种机型：iPhone XR、iPhone XS、iPhone XS Max
if (deivice=="iPhone11,8")  return "iPhone XR";
if (deivice=="iPhone11,2")  return "iPhone XS";
if (deivice=="iPhone11,4")  return "iPhone XS Max";
if (deivice=="iPhone11,6")  return "iPhone XS Max";
//2019年9月发布，更新三种机型：iPhone 11、iPhone 11 Pro、iPhone 11 Pro Max
if (deivice=="iPhone12,1")  return  "iPhone 11";
if (deivice=="iPhone12,3")  return  "iPhone 11 Pro";
if (deivice=="iPhone12,5")  return  "iPhone 11 Pro Max";

return "Unknown iPhone";
}

//iPad设备
String spFunIPadPlatform(String deivice){

if(deivice=="iPad1,1")   return "iPad";
if(deivice=="iPad1,2")   return "iPad 3G";
if(deivice=="iPad2,1")   return "iPad 2 (WiFi)";
if(deivice=="iPad2,2")   return "iPad 2";
if(deivice=="iPad2,3")   return "iPad 2 (CDMA)";
if(deivice=="iPad2,4")   return "iPad 2";
if(deivice=="iPad2,5")   return "iPad Mini (WiFi)";
if(deivice=="iPad2,6")   return "iPad Mini";
if(deivice=="iPad2,7")   return "iPad Mini (GSM+CDMA)";
if(deivice=="iPad3,1")   return "iPad 3 (WiFi)";
if(deivice=="iPad3,2")   return "iPad 3 (GSM+CDMA)";
if(deivice=="iPad3,3")   return "iPad 3";
if(deivice=="iPad3,4")   return "iPad 4 (WiFi)";
if(deivice=="iPad3,5")   return "iPad 4";
if(deivice=="iPad3,6")   return "iPad 4 (GSM+CDMA)";
if(deivice=="iPad4,1")   return "iPad Air (WiFi)";
if(deivice=="iPad4,2")   return "iPad Air (Cellular)";
if(deivice=="iPad4,4")   return "iPad Mini 2 (WiFi)";
if(deivice=="iPad4,5")   return "iPad Mini 2 (Cellular)";
if(deivice=="iPad4,6")   return "iPad Mini 2";
if(deivice=="iPad4,7")   return "iPad Mini 3";
if(deivice=="iPad4,8")   return "iPad Mini 3";
if(deivice=="iPad4,9")   return "iPad Mini 3";
if(deivice=="iPad5,1")   return "iPad Mini 4 (WiFi)";
if(deivice=="iPad5,2")   return "iPad Mini 4 (LTE)";
if(deivice=="iPad5,3")   return "iPad Air 2";
if(deivice=="iPad5,4")   return "iPad Air 2";
if(deivice=="iPad6,3")   return "iPad Pro 9.7";
if(deivice=="iPad6,4")   return "iPad Pro 9.7";
if(deivice=="iPad6,7")   return "iPad Pro 12.9";
if(deivice=="iPad6,8")   return "iPad Pro 12.9";
if(deivice=="iPad6,11")  return "iPad 5 (WiFi)";
if(deivice=="iPad6,12")  return "iPad 5 (Cellular)";
if(deivice=="iPad7,1")   return "iPad Pro 12.9 inch 2nd gen (WiFi)";
if(deivice=="iPad7,2")   return "iPad Pro 12.9 inch 2nd gen (Cellular)";
if(deivice=="iPad7,3")   return "iPad Pro 10.5 inch (WiFi)";
if(deivice=="iPad7,4")   return "iPad Pro 10.5 inch (Cellular)";
//2019年3月发布，更新二种机型：iPad mini、iPad Air
if (deivice=="iPad11,1")   return "iPad mini (5th generation)";
if (deivice=="iPad11,2")   return "iPad mini (5th generation)";
if (deivice=="iPad11,3")   return "iPad Air (3rd generation)";
if (deivice=="iPad11,4")   return "iPad Air (3rd generation)";

return deivice;
}

//iPod设备
String spFunIPodPlatform(String deivice){

if (deivice=="iPod1,1")      return "iPod Touch 1G";
if (deivice=="iPod2,1")      return "iPod Touch 2G";
if (deivice=="iPod3,1")      return "iPod Touch 3G";
if (deivice=="iPod4,1")      return "iPod Touch 4G";
if (deivice=="iPod5,1")      return "iPod Touch (5 Gen)";
if (deivice=="iPod7,1")      return "iPod touch (6th generation)";
//2019年5月发布，更新一种机型：iPod touch (7th generation)
if (deivice=="iPod9,1")      return "iPod touch (7th generation)";

return deivice;
}




}
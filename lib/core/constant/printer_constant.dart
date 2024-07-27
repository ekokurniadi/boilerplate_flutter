abstract class PrinterConstant {
  // * Paper Size
  static const paperSize58mm = '58 mm';
  static const paperSize80mm = '80 mm';
  static const paperSizes = [paperSize58mm, paperSize80mm];

  // * Printer Type
  static const typeBluetooth = 'Bluetooth';
  static const typeWifi = 'WiFi / LAN';
  static const typeUsb = 'USB';
  static const printerTypes = [typeBluetooth, typeWifi, typeUsb];
  static const printerTypesMobile = [typeBluetooth, typeWifi];

  // * URL Type
  static const urlTypeOff = 'Off';
  static const urlTypeUrl = 'URL';
  static const urlTypeQr = 'QR';
  static const urlTypes = [urlTypeOff, urlTypeUrl, urlTypeQr];
}
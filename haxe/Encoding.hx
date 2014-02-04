package haxe;

import haxe.io.Bytes;

@:final class Encoding {

    public var asciiCompatible (default, null): Bool;

    public var codePage (default, null): Null<Int>;
    // http://msdn.microsoft.com/en-us/library/windows/desktop/dd317756.aspx
    // neko, cpp - windows.h: http://msdn.microsoft.com/en-us/library/windows/desktop/dd319072.aspx
    // http://msdn.microsoft.com/en-us/library/system.text.encoding.aspx
    // c#: http://msdn.microsoft.com/en-us/library/kdcak6ye.aspx

    public var iconvCharset (default, null): String;
    // http://www.gnu.org/software/libiconv/
    // neko, cpp - iconv: http://www.gnu.org/savannah-checkouts/gnu/libiconv/documentation/libiconv-1.13/iconv.3.html
    // php: http://php.net/manual/en/function.iconv.php

    public var ianaCharset (default, null): String;
    // http://www.iana.org/assignments/character-sets/character-sets.xhtml
    // java: http://docs.oracle.com/javase/7/docs/api/java/lang/String.html#getBytes(java.lang.String)

    public var flashCharset (default, null): String;
    // http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/charset-codes.html
    // as3: http://help.adobe.com/en_US/FlashPlatform/reference/actionscript/3/flash/utils/ByteArray.html#readMultiByte()

    private function new(asciiCompatible: Bool = true,
                         codePage: Null<Int> = null,
                         iconvCharset: String = null,
                         ianaCharset: String = null,
                         flashCharset: String = null
                         ) {
        this.asciiCompatible = asciiCompatible;
        this.codePage = codePage;
        this.iconvCharset = iconvCharset;
        this.ianaCharset = ianaCharset;
        this.flashCharset = flashCharset;
    }

    public static function encode(string: String, to: Encoding): Bytes {
        #if php
        return Bytes.ofString(
            untyped __call__("iconv",
            Encoding.Utf8.iconvCharset, to.iconvCharset + "//IGNORE",
            string)
        );
        #else
        return Bytes.alloc(0); // TODO
        #end
    }

    public static function decode(bytes: Bytes, from: Encoding): String {
        #if php
        return untyped __call__("iconv",
            from.iconvCharset, Encoding.Utf8.iconvCharset + "//IGNORE",
            bytes.toString());
        #else
        return ""; // TODO
        #end
    }

    public static function convert(from: Encoding, to: Encoding, bytes: Bytes): Bytes {
        #if php
        return Bytes.ofString(
            untyped __call__("iconv",
            from.iconvCharset, to.iconvCharset + "//IGNORE",
            bytes.toString())
        );
        #else
        return Bytes.alloc(0); // TODO
        #end
    }

    // unicode
    public static var Utf8: Encoding = new Encoding(true, 65001, "UTF-8", "UTF-8", "utf-8");

    // korean
    public static var Cp949: Encoding = new Encoding(true, 949, "CP949", "KS_C_5601-1987", "ks_c_5601-1987");
    public static var EucKr: Encoding = new Encoding(true, 51949, "EUC-KR", "csEUCKR", "csEUCKR");

}

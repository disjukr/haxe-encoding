import haxe.Encoding;
import haxe.unit.TestCase;
import haxe.unit.TestRunner;

class Test extends TestCase {
    public function new() {
        super();
    }
    public static function main() {
        var runner = new TestRunner();
        runner.add(new Test());
        runner.run();
    }
    public function testKoreanEncoding() {
        var euckr = Encoding.encode("안녕", Encoding.EucKr);
        assertEquals(0xBE, euckr.get(0)); // 안
        assertEquals(0xC8, euckr.get(1));
        assertEquals(0xB3, euckr.get(2)); // 녕
        assertEquals(0xE7, euckr.get(3));
        var cp949 = Encoding.encode("똠방각하", Encoding.Cp949);
        assertEquals(0x8C, cp949.get(0)); // 똠
        assertEquals(0x63, cp949.get(1));
        // 아 몰라 잘 되겠지 뭐
    }
    public function testConvert() {
        var a = Encoding.encode("가힣", Encoding.Cp949);
        var b = Encoding.decode(a, Encoding.Cp949);
        assertEquals(b, "가힣");
        var c = Encoding.convert(Encoding.Cp949, Encoding.defaultEncoding, a);
        assertEquals(c.toString(), "가힣");
    }
}

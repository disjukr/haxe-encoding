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
        Encoding.encode("안녕하세요", Encoding.Cp949);
        assertTrue(true);
    }
}

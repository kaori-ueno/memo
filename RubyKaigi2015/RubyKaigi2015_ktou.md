- 1.3
  - testsupp
    - Perl のようなAPIテストモジュール
- 1.4
  - RubyUnit
   - Ruby では初のxUnit系テスト
   - Rubyっぽい
   - テストジェネレータがある
   - テスト実行コマンドがある
- 1.6
  - Lapidary
    - Rubyっぽくない
    - GUIのテスト実行機能あり
- 1.7
  - Test::Unit
    - = Lapidary Impl + RubyUnit API
    - Rubyっぽい
- 1.8
  - Test::Unit
    - bundleされる
    - メンテなー交代(minitestの開発者)
    - 複雑すぎてメンテできない！！！
  - RSpec
    - 振る舞い開発？
    - 英語っぽい
- 1.9
  - Test::Unit
    - さよならー
    - test-unit gem として切り出された
    - 私はメンテナンスできるのでしてるお
  - minitest
    - 小さい、シンプル、きれい、はやい
  - test/unit
    - minitestのラッパー
    - Test::Unitとは違うよ！！
- 2.0
- 2.1
  - minitest
    - ver5で非互換の機能がある
    - test/unitめんてできない！捨てる！
    - あん1
      - × ver.4しか使わせねぇ
      - ○ rubyのテストにはver.4を使う！
- 2.2
  - bundleするのはminitest5
  - ruby開発者はminitest4をforkして使う

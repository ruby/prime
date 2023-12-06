require "test/unit"

require "rbs"
require "rbs/unit_test"

require "prime"

module RBSTypeTest
  class PrimeSingletonTest < Test::Unit::TestCase
    include RBS::UnitTest::TypeAssertions

    library "singleton", "prime"
    testing "singleton(::Prime)"

    def test_each
      assert_send_type(
        "() { (::Integer) -> void } -> void",
        Prime, :each, &proc { break_from_block }
      )

      assert_send_type(
        "(::Integer? ubound) { (::Integer) -> void } -> void",
        Prime, :each, 10, &proc { break_from_block }
      )

      assert_send_type(
        "(::Integer? ubound, ::Prime::PseudoPrimeGenerator generator) { (::Integer) -> void } -> void",
        Prime, :each, 10, Prime::TrialDivisionGenerator.new, &proc { break_from_block }
      )

      assert_send_type(
        "() -> ::Prime::PseudoPrimeGenerator",
        Prime, :each
      )
    end

    def test_int_from_prime_division
      assert_send_type "(::Array[[ ::Integer, ::Integer ]]) -> ::Integer",
                       Prime, :int_from_prime_division, [[3, 1], [19, 1]]
    end

    def test_prime?
      assert_send_type "(::Integer) -> bool",
                       Prime, :prime?, 57
    end

    def test_prime_division
      assert_send_type "(::Integer) -> ::Array[[ ::Integer, ::Integer ]]",
                       Prime, :prime_division, 57
    end

    def test_instance
      assert_send_type "() -> ::Prime",
                       Prime, :instance
    end
  end

  class PrimeInstanceTest < Test::Unit::TestCase
    include RBS::UnitTest::TypeAssertions

    library "singleton", "prime"
    testing "::Prime"

    def test_each
      assert_send_type(
        "() { (::Integer) -> void } -> void",
        Prime.instance, :each, &proc { break_from_block }
      )
      assert_send_type(
        "(::Integer? ubound) { (::Integer) -> void } -> void",
        Prime.instance, :each, 10, &proc { break_from_block }
      )
      assert_send_type(
        "(::Integer? ubound, ::Prime::PseudoPrimeGenerator generator) { (::Integer) -> void } -> void",
        Prime.instance, :each, 10, Prime::TrialDivisionGenerator.new, &proc { break_from_block }
      )
      assert_send_type(
        "() -> ::Prime::PseudoPrimeGenerator",
        Prime.instance, :each
      )
    end

    def test_int_from_prime_division
      assert_send_type "(::Array[[ ::Integer, ::Integer ]]) -> ::Integer",
                       Prime.instance, :int_from_prime_division, [[3, 1], [19, 1]]
    end

    def test_prime?
      assert_send_type "(::Integer value) -> bool",
                       Prime.instance, :prime?, 57
    end

    def test_prime_division
      assert_send_type "(::Integer) -> ::Array[[ ::Integer, ::Integer ]]",
                       Prime.instance, :prime_division, 57
    end
  end
end

using FluentAssertions;
using Square.Foundation.Configuration.Variables;
using Xunit;

namespace Square.Foundation.Configuration.Tests.Variables
{
    public class VariableExtractorTests
    {
        private const string Prefix = "cs";

        private readonly VariableExtractor _sut;

        public VariableExtractorTests()
        {
            _sut = new VariableExtractor(Prefix);
        }

        [Fact]
        public void WhenInputIsWhitespaceOrNull_ReturnsEmptyDictionary()
        {
            // arrange

            // act
            var resultA = _sut.Extract(null);
            var resultB = _sut.Extract("");
            var resultC = _sut.Extract("        ");

            // assert
            resultA.Should().NotBeNull();
            resultA.Count.Should().Be(0);

            resultB.Should().NotBeNull();
            resultB.Count.Should().Be(0);

            resultC.Should().NotBeNull();
            resultC.Count.Should().Be(0);
        }

        [Fact]
        public void WhenOneVariable_ReturnsOneElementInDictionary()
        {
            // arrange
            var input = "$(cs:core)";

            // act
            var result = _sut.Extract(input);

            // assert
            result.Should().NotBeNull();
            result.Count.Should().Be(1);
            result["$(cs:core)"].Should().Be("core");
        }

        [Fact]
        public void WhenTwoTheSameVariables_ReturnsOneElementInDictionary()
        {
            // arrange
            var input = "$(cs:core) $(cs:core)";

            // act
            var result = _sut.Extract(input);

            // assert
            result.Should().NotBeNull();
            result.Count.Should().Be(1);
            result["$(cs:core)"].Should().Be("core");
        }

        [Fact]
        public void WhenTwoDifferentVariables_ReturnsTwoElementsInDictionary()
        {
            // arrange
            var input = "$(cs:core) $(cs:master)";

            // act
            var result = _sut.Extract(input);

            // assert
            result.Should().NotBeNull();
            result.Count.Should().Be(2);
            result["$(cs:core)"].Should().Be("core");
            result["$(cs:master)"].Should().Be("master");
        }

        [Fact]
        public void WhenOneInvalidVariable_ReturnsEmptyDictionary()
        {
            // arrange
            var input = "$(cs:core";

            // act
            var result = _sut.Extract(input);

            // assert
            result.Should().NotBeNull();
            result.Count.Should().Be(0);
        }

        [Fact]
        public void WhenFirstOneValidAndSecondOneInvalidVariable_ReturnsOneElementInDictionary()
        {
            // arrange
            var input = "$(cs:core) $(cs:master";

            // act
            var result = _sut.Extract(input);

            // assert
            result.Should().NotBeNull();
            result.Count.Should().Be(1);
            result["$(cs:core)"].Should().Be("core");
        }

        [Fact]
        public void WhenFirstOneInvalidAndSecondOneValidVariable_ReturnsOneElementInDictionary()
        {
            // arrange
            var input = "$(cs:core $(cs:master)";

            // act
            var result = _sut.Extract(input);

            // assert
            result.Should().NotBeNull();
            result.Count.Should().Be(1);
            result["$(cs:core $(cs:master)"].Should().Be("core $(cs:master");
        }

        [Fact]
        public void WhenInputIsShort_HandleItGracefully()
        {
            // arrange
            var input = "web";

            // act
            var result = _sut.Extract(input);

            // assert
            result.Should().NotBeNull();
            result.Count.Should().Be(0);
        }
    }
}
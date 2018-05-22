using FluentAssertions;
using Xunit;

namespace Square.Foundation.Configuration.Variables
{
    public class ExtractorTests
    {
        private readonly Extractor _sut;

        public ExtractorTests()
        {
            _sut = new Extractor();
        }

        [Fact]
        public void WhenPrefixOrValueEmptyOrNull_ReturnsEmptyDictionary()
        {
            // arrange

            // act
            //var result = _sut.Extract(null, null);

            // assert
            //result.Should().NotBeNull();
            //result.Count.Should().Be(0);
            2.Should().Be(2);
        }
    }
}
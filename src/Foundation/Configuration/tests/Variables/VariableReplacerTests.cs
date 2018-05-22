using FluentAssertions;
using NSubstitute;
using Square.Foundation.Configuration.Variables;
using Square.Foundation.Configuration.Variables.Abstract;
using System.Collections.Generic;
using Xunit;

namespace Square.Foundation.Configuration.Tests.Variables
{
    public class VariableReplacerTests
    {
        private readonly IVariableExtractor _variableExtractor;
        private readonly IValueProvider _valueProvider;

        private readonly VariableReplacer _sut;

        public VariableReplacerTests()
        {
            _variableExtractor = Substitute.For<IVariableExtractor>();
            _valueProvider = Substitute.For<IValueProvider>();

            _sut = new VariableReplacer(_variableExtractor, _valueProvider);
        }

        [Fact]
        public void WhenInputIsNull_ReturnsNull()
        {
            // arrange

            // act
            var result = _sut.Replace(null);

            // assert
            result.Should().BeNull();
        }

        [Fact]
        public void WhenInputHasNoVariables_ReturnsOriginalInput()
        {
            // arrange
            var input = "some value without variables";
            _variableExtractor.Extract(input).Returns(new Dictionary<string, string>());

            // act
            var result = _sut.Replace(input);

            // assert
            result.Should().Be(input);
        }

        [Fact]
        public void WhenInputHasOneVariable_ReplaceIt()
        {
            // arrange
            var input = "one variable: $(cs:name), one variable";
            var variables = new Dictionary<string, string>();
            variables.Add("$(cs:name)", "name");

            _variableExtractor.Extract(input).Returns(variables);
            _valueProvider.GetValue("name").Returns("replaced");

            // act
            var result = _sut.Replace(input);

            // assert
            result.Should().Be("one variable: replaced, one variable");
        }

        [Fact]
        public void WhenInputHasTwoVariables_ReplaceIt()
        {
            // arrange
            var input = "one variable: $(cs:one), two variable: $(cs:two)";
            var variables = new Dictionary<string, string> {{"$(cs:one)", "one"}, {"$(cs:two)", "two"}};

            _variableExtractor.Extract(input).Returns(variables);
            _valueProvider.GetValue("one").Returns("one_replaced");
            _valueProvider.GetValue("two").Returns("two_replaced");

            // act
            var result = _sut.Replace(input);

            // assert
            result.Should().Be("one variable: one_replaced, two variable: two_replaced");
        }

        [Fact]
        public void WhenInputProviderReturnsNull_DoNotReplaceIt()
        {
            // arrange
            var input = "one variable: $(cs:one), two variable: $(cs:two)";
            var variables = new Dictionary<string, string> { { "$(cs:one)", "one" }, { "$(cs:two)", "two" } };

            _variableExtractor.Extract(input).Returns(variables);
            _valueProvider.GetValue("one").Returns("one_replaced");
            _valueProvider.GetValue("two").Returns((string)null);

            // act
            var result = _sut.Replace(input);

            // assert
            result.Should().Be("one variable: one_replaced, two variable: $(cs:two)");
        }
    }
}
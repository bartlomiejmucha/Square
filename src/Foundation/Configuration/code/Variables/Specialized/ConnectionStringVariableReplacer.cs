namespace Square.Foundation.Configuration.Variables.Specialized
{
    public class ConnectionStringVariableReplacer : VariableReplacer
    {
        private const string VariablePrefix = "cs";

        public ConnectionStringVariableReplacer() : base(new VariableExtractor(VariablePrefix), new ConnectionStringsValueProvider())
        {
        }
    }
}
namespace Square.Foundation.Configuration.Variables.Abstract
{
    public interface IValueProvider
    {
        string GetValue(string key);
    }
}
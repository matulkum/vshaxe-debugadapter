package fdbAdapter;
import vshaxeDebug.types.VariableType;
import vshaxeDebug.types.VarRequestType;

class OutputParseHelper
{
    public static function detectExpressionType(expr:String)
    {
        var rObjectType = ~/^\[Object \d+/;
        var rIntType = ~/^\d+ \(0\x\d+\)/;
        var rFloatType = ~/^\d+\.\d+$/;
        var rStringType = ~/^[\\"].*[\\"]$/; 
        var rBoolType = ~/^[t|f]\S+$/;

        return if (rObjectType.match(expr))
            VariableType.Object;
        else if (rIntType.match(expr))
            VariableType.Int;
        else if (rFloatType.match(expr))
            VariableType.Float;
        else if (rStringType.match(expr))
            VariableType.String;
        else if (rBoolType.match(expr))
            VariableType.Bool;
        else
            VariableType.Unknown;
    }
}
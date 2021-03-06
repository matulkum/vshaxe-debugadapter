package fdbAdapter.commands;

import vshaxeDebug.Context;
import vshaxeDebug.DebuggerCommand;
import protocol.debug.Types.Breakpoint;

class SetBreakpoint extends DebuggerCommand {

    var breakpoint:Breakpoint;

    public function new(context:Context, breakpoint:Breakpoint) {
        this.breakpoint = breakpoint;
        super( context );
    }

    override function execute() {
        var line = breakpoint.line;
        var fname = breakpoint.source.name;
        debugger.send('break $fname:${line}');
    }

    override public function processDebuggerOutput(lines:Array<String>) {
        var breakpointData = lines[0];
        var r = ~/Breakpoint ([0-9]+).*: file ([0-9A-Za-z\.]+), line ([0-9]+)/;
        if (r.match(breakpointData)) {
            breakpoint.id   = Std.parseInt(r.matched(1));
            breakpoint.source.name = r.matched(2);
            breakpoint.line = Std.parseInt(r.matched(3));
        }
        else
            trace( 'SetBreakpoint FAILED: [ $lines ]');

        setDone();
    }
}

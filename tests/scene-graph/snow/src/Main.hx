import snow.types.Types.AppConfig;
import snow.types.Types.ModState;
import snow.types.Types.Key;

import gltoolbox.gl.GL;

class Main extends snow.App {

    override function config( config:AppConfig ):AppConfig{
        config.window.title = 'GLToolbox Scene Graph Test';

        return config;
    }

    override function ready(){
        app.window.onrender = render;
    }

    override function onkeyup( keycode:Int, _,_, mod:ModState, _,_ ){
        if( keycode == Key.escape ){
            app.shutdown();
        }
    }

    override function update( delta:Float ){

    }

    function render( window:snow.system.window.Window ){
        GL.clearColor(0.0, 1.0, 0.0, 1.0);
        GL.clear(GL.COLOR_BUFFER_BIT);
    }

}

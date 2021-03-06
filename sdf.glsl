// sdf.glsl
uniform vec2 resolution;
uniform vec2 mouse;
uniform float time;
//http://glslsandbox.com/e#49587.0         
// DOF Snowfield! 
// Mouse X controls focal depth 


vec3 snowflake(vec3 coords, vec2 pxPos) { 
	float focalPlane = 0.5 + 2.5 *mouse.x*mouse.y; 
	float iris = 0.01;
	
	float pxDiam = abs(coords.z - focalPlane) * iris; 
	vec2 flakePos = vec2(coords.xy) / coords.z; 
	float flakeDiam = 0.003 / coords.z; 
	
	float dist = length(pxPos - flakePos); 
	float bri = (pxDiam + flakeDiam - dist) / (pxDiam * 2.0); 
	if (pxDiam > flakeDiam) { 
		bri /= (pxDiam / flakeDiam); 
	} 

	return vec3(0.7, 0.9, 1.0) * min(1.0, max(0.0, bri)); 
}

void main( void ) { 
    vec2 pos = ( gl_FragCoord.xy / resolution.xy ) - 0.5; 
    pos.y *= resolution.y / resolution.x; 
     
    gl_FragColor.rgb = vec3(0.04, 0.13, 0.19); 
    for (int i=0; i<150; i++) { 
	    vec3 c = vec3(0); 
	    c.z = fract(sin(float(i) * 25.643) * 735.5373); 
	    c.z *= 0.2 + fract(sin(float(i) * 74.753) * 526.5463); 
	    c.z = 0.5 + (1.0 - c.z) * 2.4; 
	    float gSize = 0.5 / c.z; 
	    vec2 drift = vec2(0); 
	    drift.x = fract(sin(float(i) * 52.3464) * 353.43354) * 4.0; 
	    drift.x = drift.x + time * 0.06 + 4.0 * sin(time * 0.03 + c.z * 7.0); 
	    drift.y = fract(sin(float(i) * 63.2356) * 644.53463) * 4.0; 
	    drift.y = drift.y + time * -0.2; 
	    drift /= c.z; 
	     
	    vec2 grid = vec2(mod((pos.x+drift.x)/c.z, gSize), mod((pos.y-drift.y)/c.z, gSize)); 
	    c.x = gSize*0.5; 
	    c.y = gSize*0.5; 
	    gl_FragColor.rgb += snowflake(c, grid); 
    } 
    gl_FragColor.a = 1.0; 

}

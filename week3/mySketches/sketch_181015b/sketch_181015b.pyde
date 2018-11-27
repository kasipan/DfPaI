def setup():
    size(256, 256)

def draw():
    background(0)
    w = sin(millis()/500.0)*50
    ellipse(width/2, height/2, 100+w, 100+w)
    
    saveFrame('###.png')

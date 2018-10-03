
# Week 1

Do the exercises in:
* BouncingBalls
* gradient
* Grid

## What's printed and why?

### A

```processing

int a = 2;

void go() {
  a++;
}

void setup() {
  println(a);
}

```

### B

```processing
int x = 0;

void go(int x) {
  x++;
}

void setup() {
  println(x);
}
```

### C

```processing
class Thing {
  int a;
}

void go(Thing t) {
  t.a++;
}

void setup() {
  Thing thing = new Thing();
  thing.a = 2;
  
  go(thing);

  println(thing.a);
}
```
*put your answer here*

### A

**2**

because `setup()` doesn’t call `go` function. the variable `a` has not been changed.

### B

**0**

same as question A. `setup()` doesn’t call `go` function, so the `println` refers the first global variable which was declared with `0`.

### C

**3**

because in `setup()`, new `thing` object is created with a parameter containing `2`. And also `go` function is called to add `1` to this parameter. Then, finally the object `thing` has `a` containing `3`.

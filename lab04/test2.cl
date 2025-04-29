class Parent {
    x : Int <- 10;
    y : Int <- 2;
    
    divide() : Int {
        x / y
    };
};

class Child inherits Parent {
    z : Int <- 5;
    
    while_test() : Int {
        while z < 0 loop
            z <- z + 1
        pool
    };
};

class Main {
    main() : Object {
        let child : Child <- new Child in {
            child.divide();    -- должно вернуть 5 (10 / 2)
            child.while_test(); -- увеличит z с 5 до 0
        }
    };
};

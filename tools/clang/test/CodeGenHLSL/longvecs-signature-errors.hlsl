// RUN: not %dxc -T ps_6_9 %s 2>&1 | Filecheck %s

// catches errors with long vectors that are generated too late for verify tests

// CHECK: error: Entry function cannot return a vector of size > 4
// CHECK: error: Entry function cannot take a vector argument of size > 4
vector< float, 6 > main(vector< float, 6 >  f : F) : SV_Target {
    return f;
}

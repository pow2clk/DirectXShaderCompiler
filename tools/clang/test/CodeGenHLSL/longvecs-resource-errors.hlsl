// RUN: not %dxc -T lib_6_9 %s 2>&1 | Filecheck %s

// catches errors with long vectors that are generated too late for verify tests

// CHECK: error: buf contains a vector of size 8 and cannot be used in a type buffer
Buffer< vector<float, 8> > buf;


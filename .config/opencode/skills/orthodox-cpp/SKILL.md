---
name: orthodox-cpp
description: Write and review code in Orthodox C++. Orthodox C++ is a minimal subset of C++ that avoids Modern C++ features.
license: MIT
compatibility: opencode
metadata:
  audience: developers
  language: cpp
---

## Description

This document defines the agent configuration to write code in Orthodox C++.
Orthodox C++ is a minimal subset of C++.
Orthodox C++ improves the C language.
Orthodox C++ avoids complex features of Modern C++.
Code in Orthodox C++ is easy to understand.
Code in Orthodox C++ compiles with old compilers.

## Instructions

Apply the following rules to generate code and review code.

1. Write the code with a structure similar to the C language.
2. If the problem does not require complexity, do not add C++ structures.
3. Write readable code for C language programmers.
4. Do not use exceptions.
5. Do not use RTTI.
6. Use C library inclusions.
7. Use header files like `<stdio.h>` and `<math.h>`.
8. Do not use C++ wrappers like `<cstdio>` or `<cmath>`.
9. Use functions from the `printf` family.
10. Do not use stream libraries like `<iostream>` or `<stringstream>`.
11. If you need to manage memory, do not use STL elements that allocate memory.
12. Use metaprogramming moderately.
13. If metaprogramming reduces code complexity, apply metaprogramming.
14. Do not use modules.
15. If the current year is greater than or equal to the C++ standard year plus 5, use the functions of that standard.
16. Use the functions of the C++20 standard.

## Base code example

Use the following format for the main structure of the programs.

```cpp
#include <stdio.h>

int main()
{
    printf("hello, world\n");
    return 0;
}
```
